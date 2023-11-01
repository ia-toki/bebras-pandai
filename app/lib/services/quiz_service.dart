// import 'package:airplane/models/destination_model.dart';
// ignore_for_file: inference_failure_on_collection_literal
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/quiz_participation.dart';
import '../models/weekly_quiz.dart';
import 'firebase_service.dart';

class QuizService {
  final CollectionReference _runningWeeklyQuizRef =
      FirebaseFirestore.instance.collection('configuration');
  final CollectionReference _weeklyQuizListRef =
      FirebaseFirestore.instance.collection('weekly_quiz_list');
  final CollectionReference _weeklyQuizParticipantRef =
      FirebaseFirestore.instance.collection('weekly_quiz_participation');

  Future<WeeklyQuizModel> getWeeklyQuiz(String week) async {
    try {
      final snapshot = await _runningWeeklyQuizRef.doc(week).get();
      return WeeklyQuizModel(
        id: snapshot.id,
        title: snapshot['title'] as String,
        created_at: snapshot['created_at'] as String,
        duration_minute: snapshot['duration_minute'] as Map<String, dynamic>,
        end_at: snapshot['end_at'] as String,
        max_attempts: snapshot['max_attempts'] as Map<String, dynamic>,
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

  Future<WeeklyQuizModel> getQuiz(String quizId) async {
    try {
      final snapshot = await _weeklyQuizListRef.doc(quizId).get();
      final x = (snapshot['tasks'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(key, List<String>.from(value as List<dynamic>)));
      return WeeklyQuizModel(
        id: snapshot.id,
        title: snapshot['title'] as String,
        created_at: snapshot['created_at'] as String,
        duration_minute: snapshot['duration_minute'] as Map<String, dynamic>,
        end_at: snapshot['end_at'] as String,
        max_attempts: snapshot['max_attempts'] as Map<String, dynamic>,
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
    // final weeklyQuiz = await fetchWeeklyQuiz(week);
    final snapshot = await _runningWeeklyQuizRef.doc(week).get();

    try {
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      await _weeklyQuizParticipantRef.doc().set({
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

  Future<WeeklyQuizParticipation> getWeeklyQuizParticipant({
    required String quizParticipantId,
  }) async {
    try {
      final result =
          await _weeklyQuizParticipantRef.doc(quizParticipantId).get();
      return WeeklyQuizParticipation.fromJson(
          result.id, result.data()! as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WeeklyQuizParticipation>> getRunningWeeklyQuizByParticipantUid(
    String participantUid,
  ) async {
    try {
      final result = await _weeklyQuizParticipantRef
          .where('user_uid', isEqualTo: participantUid)
          .orderBy('quiz_start_at', descending: true)
          .get();

      final participantQuizzes = result.docs.map((e) {
        return WeeklyQuizParticipation.fromJson(
          e.id,
          e.data()! as Map<String, dynamic>,
        );
      }).toList();

      return participantQuizzes;
    } catch (e) {
      rethrow;
    }
  }
}
