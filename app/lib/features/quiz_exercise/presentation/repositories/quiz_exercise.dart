import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../services/firebase_service.dart';
import '../model/quiz_exercise.dart';
import '../model/quiz_exercise_attempt.dart';

@injectable
class QuizExerciseRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  QuizExerciseRepository() {
    db.settings = FirebaseService.settings;
  }

  Future<List<QuizExercise>> getListQuizExerciseByTaskIdList(
    List<String> taskIdList,
  ) async {
    final quizExerciseList = <QuizExercise>[];
    try {
      final result = await db.collection('task_set').get();
      final taskResult =
          result.docs.where((element) => taskIdList.contains(element.id));
      for (final element in taskResult) {
        quizExerciseList.add(QuizExercise.fromJson(element.data()));
      }

      return quizExerciseList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
      return quizExerciseList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<QuizExercise>> getListQuizExercise() async {
    final quizExerciseList = <QuizExercise>[];
    try {
      final result = await db.collection('task_set').get();
      for (final element in result.docs) {
        quizExerciseList.add(QuizExercise.fromJson(element.data()));
      }

      return quizExerciseList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
      return quizExerciseList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<QuizExercise> getQuizExercise(String taskId) async {
    try {
      final result =
          await db.collection('task_set').where('id', isEqualTo: taskId).get();
      if (result.docs.isEmpty) {
        throw Exception('Task ID not found');
      }
      final data = result.docs.first;
      return QuizExercise.fromJson(data.data());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> insertQuizExerciseAttempt(
    String quizParticipantId,
    QuizExerciseAttempt attempt,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('weekly_quiz_participation')
          .doc(quizParticipantId)
          .update({
        'attempts': FieldValue.arrayUnion([attempt.toJson()]),
      });
    } catch (e) {
      rethrow;
    }
  }
}
