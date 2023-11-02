// import 'package:airplane/models/destination_model.dart';
// ignore_for_file: inference_failure_on_collection_literal
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quiz_participation.dart';
import '../models/weekly_quiz.dart';

class QuizService {
  final CollectionReference _runningWeeklyQuizRef =
      FirebaseFirestore.instance.collection('configuration');
  final CollectionReference _weeklyQuizListRef =
      FirebaseFirestore.instance.collection('weekly_quiz_list');
  final CollectionReference _weeklyQuizParticipantRef =
      FirebaseFirestore.instance.collection('weekly_quiz_participation');
  final _registeredUserRef =
      FirebaseFirestore.instance.collection('registered_user');

  Future<WeeklyQuiz> getWeeklyQuiz(String week) async {
    try {
      final snapshot = await _runningWeeklyQuizRef.doc(week).get();
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

  Future<WeeklyQuiz> getQuiz(String quizId) async {
    try {
      final snapshot = await _weeklyQuizListRef.doc(quizId).get();
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
      final result =
          await _weeklyQuizParticipantRef.doc(quizParticipantId).get();
      return WeeklyQuizParticipation.fromJson(
          result.id, result.data()! as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
