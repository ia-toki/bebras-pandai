import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../model/quiz_exercise.dart';
import '../model/quiz_exercise_attempt.dart';

@injectable
class QuizExerciseRepository {
  Future<List<QuizExercise>> getListQuizExercise(
    List<String> taskIdList,
  ) async {
    final quizExerciseList = <QuizExercise>[];
    try {
      final result =
          await FirebaseFirestore.instance.collection('task_set').get();
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

  Future<QuizExercise> getQuizExercise(String taskId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('task_set')
          .doc(taskId)
          .get();
      return QuizExercise.fromJson(result.data()!);
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
