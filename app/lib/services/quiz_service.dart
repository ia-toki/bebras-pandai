// ignore_for_file: inference_failure_on_collection_literal
// import 'package:airplane/models/destination_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/quiz_participation.dart';
import '../../../models/weekly_quiz.dart';
import '../../../services/firebase_service.dart';

class QuizService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String currentUserUID = FirebaseService.auth().currentUser!.uid;

  QuizService() {
    db.settings = FirebaseService.settings;
  }

  // week => running_weekly_quiz or next_weekly_quiz
  Future<bool> checkParticipantWeeklyQuiz(String week) async {
    try {
      final quizConfiguration = await getWeeklyQuizByWeek(week);
      final registeredQuizes =
          await getRunningWeeklyQuizByParticipantUid(currentUserUID);

      for (final registeredQuiz in registeredQuizes) {
        if (quizConfiguration.id == registeredQuiz.quiz_id) {
          return true;
        }
      }

      return false;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // week => running_weekly_quiz or next_weekly_quiz
  Future<void> registerParticipant(String week, String level) async {
    final levelLowerCase = level.toLowerCase();
    final snapshot = await db.collection('configuration').doc(week).get();
    final registeredUserSnapshot =
        await db.collection('registered_user').doc(currentUserUID).get();

    // background task untuk fetch task untuk sesuai minggu dan level
    // yang akan didaftarkan agar bisa dipakai offline
    for (final taskId in snapshot['tasks'][level] as List<dynamic>) {
      await fetchWeeklyQuizTaskSet(taskId.toString());
    }

    try {
      await db.collection('weekly_quiz_participation').doc().set({
        'attempts': [],
        'quiz_title': snapshot['title'],
        'challenge_group': level,
        'quiz_end_at': snapshot['end_at'],
        'quiz_id': snapshot['id'],
        'quiz_max_attempts': snapshot['max_attempts'][levelLowerCase],
        'quiz_start_at': snapshot['start_at'],
        'user_name': registeredUserSnapshot['name'],
        'user_uid': currentUserUID,
        'created_at': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchWeeklyQuizTaskSet(String taskId) async {
    try {
      final result =
          await db.collection('task_set').where('id', isEqualTo: taskId).get();
      final data = result.docs.first;

      return data.data();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WeeklyQuizParticipation>> getRunningWeeklyQuizByParticipantUid(
    String participantUid,
  ) async {
    // final prefs = await SharedPreferences.getInstance();

    try {
      final result = await db
          .collection('weekly_quiz_participation')
          .where('user_uid', isEqualTo: participantUid)
          .orderBy('quiz_start_at', descending: true)
          .get();

      // final participantQuizzesListJson = [];

      final participantQuizzes = result.docs.map((e) {
        // participantQuizzesListJson.add(e.data());
        return WeeklyQuizParticipation.fromJson(
          e.id,
          e.data(),
        );
      }).toList();

      // final encodedQuizList =
      //     jsonEncode({'quiz_list': participantQuizzesListJson});

      // await prefs.setString('quiz_list', encodedQuizList);

      return participantQuizzes;
    } catch (e) {
      rethrow;
    }
  }

  Future<WeeklyQuiz> getWeeklyQuizByWeek(String week) async {
    try {
      final snapshot = await db.collection('configuration').doc(week).get();
      return WeeklyQuiz.fromJson(
        snapshot['id'] as String,
        snapshot.data()!,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<WeeklyQuiz> getWeeklyQuizById(String quizId) async {
    try {
      final snapshot =
          await db.collection('weekly_quiz_list').doc(quizId).get();
      return WeeklyQuiz.fromJson(
        snapshot.id,
        snapshot.data()!,
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
        result.id,
        result.data()!,
      );
    } catch (e) {
      rethrow;
    }
  }
}
