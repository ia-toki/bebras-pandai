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

  Future<List<QuizExercise>> getListQuizExercise(
      {List<String>? taskIds}) async {
    final quizExerciseList = <QuizExercise>[];
    try {
      if (taskIds == null) {
        final globalResult =
            await db.collection('configuration').doc('global_variables').get();
        final taskSet = globalResult.get('task_set_doc_index') as List<dynamic>;
        taskIds = taskSet.map((e) => e['doc_id'] as String) as List<String>;
      }

      final taskListResult =
          await db.collection('task_set').where('id', whereIn: taskIds).get();
      for (final element in taskListResult.docs) {
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

  Future<List<QuizExerciseBase>> getListQuizExerciseBase(String group) async {
    final quizExerciseBaseList = <QuizExerciseBase>[];
    try {
      final globalResult =
          await db.collection('configuration').doc('global_variables').get();

      final taskSet = globalResult.get('task_set_doc_$group') as List<dynamic>;
      for (final element in taskSet) {
        quizExerciseBaseList
            .add(QuizExerciseBase.fromJson(element as Map<String, dynamic>));
      }

      return quizExerciseBaseList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
      return quizExerciseBaseList;
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

  Future<void> updateQuizExercise(
    String taskId,
    String? status,
  ) async {
    try {
      // Update Status Task Set
      await FirebaseFirestore.instance
          .collection('task_set')
          .doc(taskId)
          .update({
        'status': status,
      });

      // Dapatkan referensi ke dokumen yang akan diperbarui
      final globalResult = FirebaseFirestore.instance
          .collection('configuration')
          .doc('global_variables');

      // Dapatkan data saat ini dari dokumen
      final snapshot = await globalResult.get();

      // Dapatkan list task_set_doc_index
      final taskSet = snapshot['task_set_doc_index'] as List<dynamic>;
      final weeklyQuizNumber = snapshot['weeklyquiz_number'] as int;

      // Temukan indeks dari dokumen dengan doc_id yang sesuai
      var indexToUpdate = -1;
      for (var i = 0; i < taskSet.length; i++) {
        if (taskSet[i]['doc_id'] == taskId) {
          indexToUpdate = i;
          break;
        }
      }

      // Jika indeks ditemukan, lakukan pembaruan
      if (indexToUpdate != -1) {
        taskSet[indexToUpdate]['status'] = status;
      }

      // Update Status Configuration
      await globalResult.update({
        'task_set_doc_index': taskSet,
        'weeklyquiz_number': weeklyQuizNumber
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
