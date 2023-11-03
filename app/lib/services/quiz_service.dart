// import 'package:airplane/models/destination_model.dart';
// ignore_for_file: inference_failure_on_collection_literal
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/quiz_participation.dart';
import '../../../models/weekly_quiz.dart';
import '../../../services/firebase_service.dart';

class QuizService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  QuizService() {
    db.settings = const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }

  Future<WeeklyQuiz> getWeeklyQuiz(String week) async {
    try {
      final snapshot = await db.collection('configuration').doc(week).get();
      return WeeklyQuiz(
        id: snapshot.id,
        title: snapshot['title'] as String,
        created_at: snapshot['created_at'] as String,
        duration_minute: (snapshot['duration_minute'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int)),
        end_at: snapshot['end_at'] as String,
        max_attempts: (snapshot['max_attempts'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int)),
        problems: (snapshot['tasks'] as Map<String, dynamic>).map(
            (key, value) =>
                MapEntry(key, List<String>.from(value as List<dynamic>))),
        sponsors: snapshot['sponsors'] as Map<String, dynamic>,
        start_at: snapshot['start_at'] as String,
      );
    } catch (e) {
      rethrow;
    }
  }

  // week => running_weekly_quiz or next_weekly_quiz
  Future<bool> checkParticipantWeeklyQuiz(String week) async {
    try {
      final quizConfiguration = await fetchWeeklyQuiz(week);
      final participantUid = FirebaseService.auth().currentUser!.uid;
      final registeredQuizes =
          await getRunningWeeklyQuizByParticipantUid(participantUid);

      for (final registeredQuiz in registeredQuizes) {
        if (quizConfiguration.id == registeredQuiz.quiz_id) {
          return true;
        }
      }

      return false;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<WeeklyQuiz> fetchWeeklyQuiz(String week) async {
    try {
      final snapshot = await db.collection('configuration').doc(week).get();
      return WeeklyQuiz(
        id: snapshot['id'] as String,
        title: snapshot['title'] as String,
        created_at: snapshot['created_at'] as String,
        duration_minute: (snapshot['duration_minute'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int)),
        end_at: snapshot['end_at'] as String,
        max_attempts: (snapshot['max_attempts'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int)),
        problems: (snapshot['tasks'] as Map<String, dynamic>).map(
            (key, value) =>
                MapEntry(key, List<String>.from(value as List<dynamic>))),
        sponsors: snapshot['sponsors'] as Map<String, dynamic>,
        start_at: snapshot['start_at'] as String,
      );
    } catch (e) {
      rethrow;
    }
  }

  // week => running_weekly_quiz or next_weekly_quiz
  Future<void> registerParticipant(String week, String level) async {
    final levelLowerCase = level.toLowerCase();
    final snapshot = await db.collection('configuration').doc(week).get();

    // background task untuk fetch task untuk sesuai minggu dan level
    // yang akan didaftarkan agar bisa dipakai offline
    for (final taskId in snapshot['tasks'][level] as List<dynamic>) {
      await fetchWeeklyQuizTaskSet(taskId.toString());
    }

    try {
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      await db.collection('weekly_quiz_participation').doc().set({
        'attempts': [],
        'quiz_title': snapshot['title'],
        'challenge_group': level,
        'quiz_end_at': snapshot['end_at'],
        'quiz_id': snapshot['id'],
        'quiz_max_attempts': snapshot['max_attempts'][levelLowerCase],
        'quiz_start_at': snapshot['start_at'],
        'user_name': FirebaseService.auth().currentUser?.displayName,
        'user_uid': FirebaseService.auth().currentUser?.uid,
        'created_at': dateFormat.format(DateTime.now()),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> fetchWeeklyQuizTaskSet(String taskId) async {
    try {
      final result = await db.collection('task_set').doc(taskId).get();

      return result['question'].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WeeklyQuizParticipation>> getRunningWeeklyQuizByParticipantUid(
    String participantUid,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final result = await db
          .collection('weekly_quiz_participation')
          .where('user_uid', isEqualTo: participantUid)
          .orderBy('quiz_start_at', descending: true)
          .get();

      final participantQuizzesListJson = [];

      final participantQuizzes = result.docs.map((e) {
        participantQuizzesListJson.add(e.data());
        return WeeklyQuizParticipation.fromJson(
          e.id,
          e.data(),
        );
      }).toList();

      final encodedQuizList =
          jsonEncode({'quiz_list': participantQuizzesListJson});

      await prefs.setString('quiz_list', encodedQuizList);

      return participantQuizzes;
    } catch (e) {
      rethrow;
    }
  }

  Future<WeeklyQuiz> getQuiz(String quizId) async {
    try {
      final snapshot =
          await db.collection('weekly_quiz_list').doc(quizId).get();
      final x = (snapshot['tasks'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, List<String>.from(value as List<dynamic>)));
      return WeeklyQuiz(
        id: snapshot.id,
        title: snapshot['title'] as String,
        created_at: snapshot['created_at'] as String,
        duration_minute: (snapshot['duration_minute'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int)),
        end_at: snapshot['end_at'] as String,
        max_attempts: (snapshot['max_attempts'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int)),
        problems: (snapshot['tasks'] as Map<String, dynamic>).map(
            (key, value) =>
                MapEntry(key, List<String>.from(value as List<dynamic>))),
        sponsors: snapshot['sponsors'] as Map<String, dynamic>,
        start_at: snapshot['start_at'] as String,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<WeeklyQuizParticipation> getWeeklyQuizParticipant({
    required String quizParticipantId,
  }) async {
    try {
      final result = await db
          .collection('weekly_quiz_participation')
          .doc(quizParticipantId)
          .get();
      return WeeklyQuizParticipation.fromJson(
          result.id, result.data()! as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
