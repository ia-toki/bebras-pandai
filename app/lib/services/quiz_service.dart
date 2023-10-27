// import 'package:airplane/models/destination_model.dart';
// ignore_for_file: inference_failure_on_collection_literal
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/registered_participant.dart';
import '../models/weekly_quiz.dart';
import 'firebase_service.dart';

class QuizService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  QuizService() {
    db.settings = const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }

  Future<WeeklyQuizModel> fetchWeeklyQuiz(String week) async {
    try {
      final snapshot = await db.collection('configuration').doc(week).get();
      return WeeklyQuizModel(
        id: snapshot['id'] as String,
        title: snapshot['title'] as String,
        created_at: snapshot['created_at'] as String,
        duration_minute: snapshot['duration_minute'] as Map<String, dynamic>,
        end_at: snapshot['end_at'] as String,
        max_attempts: snapshot['max_attempts'] as Map<String, dynamic>,
        problems: snapshot['tasks'] as Map<String, dynamic>,
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
    // final weeklyQuiz = await fetchWeeklyQuiz(week);
    final snapshot = await db.collection('configuration').doc(week).get();

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

  Future<List<RegisteredParticipantModel>> getRunningWeeklyQuizByParticipantUid(
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
        return RegisteredParticipantModel.fromJson(
          e.id,
          e.data(),
        );
      }).toList();

      final encodedQuizList =
          jsonEncode({'quiz_list': participantQuizzesListJson});

      await prefs.setString('quiz_list', encodedQuizList);

      return participantQuizzes;
    } catch (e) {
      // final quizListString = prefs.getString('quiz_list');
      // final quizListDecoded = jsonDecode(quizListString.toString());
      // final quizList = quizListDecoded['quiz_list'] as List<dynamic>;

      // final participantQuizzes = quizList.map((e) {
      //   return RegisteredParticipantModel.fromJson(
      //     '',
      //     e.data()! as Map<String, dynamic>,
      //   );
      // }).toList();

      // return participantQuizzes;
      rethrow;
    }
  }
}
