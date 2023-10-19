// import 'package:airplane/models/destination_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/registered_participant.dart';
import '../models/weekly_quiz.dart';
import 'firebase_service.dart';

class QuizService {
  final CollectionReference _runningWeeklyQuizRef =
      FirebaseFirestore.instance.collection('configuration');
  final CollectionReference _weeklyQuizParticipantRef =
      FirebaseFirestore.instance.collection('weekly_quiz_participation');

  Future<WeeklyQuizModel> fetchWeeklyQuiz(String week) async {
    try {
      final snapshot = await _runningWeeklyQuizRef.doc(week).get();
      return WeeklyQuizModel(
        id: snapshot['id'] as String,
        title: snapshot['title'] as String,
        created_at: snapshot['created_at'] as String,
        duration_minute: snapshot['duration_minute'] as Map<String, dynamic>,
        end_at: snapshot['end_at'] as String,
        max_attempts: snapshot['max_attempts'] as Map<String, dynamic>,
        problems: snapshot['problems'] as Map<String, dynamic>,
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
      await _weeklyQuizParticipantRef.doc().set({
        'challenge_group': level,
        'quiz_end_at': snapshot['end_at'],
        'quiz_id': snapshot['id'],
        'quiz_max_attempts': snapshot['max_attempts'][levelLowerCase],
        'quiz_start_at': snapshot['start_at'],
        'user_name': FirebaseService.auth().currentUser?.displayName,
        'user_uid': FirebaseService.auth().currentUser?.uid,
      });
    } catch (e) {
      rethrow;
    }
  }
}
