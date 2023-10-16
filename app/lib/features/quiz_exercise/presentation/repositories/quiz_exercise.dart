import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../model/quiz_exercise.dart';

@injectable
class QuizExerciseRepository {
  final _firecloud = FirebaseFirestore.instance.collection('task_set');

  Future<List<QuizExercise>> getAll() async {
    List<QuizExercise> quizExerciseList = [];
    try {
      final result =
          await FirebaseFirestore.instance.collection('task_set').get();

      result.docs.forEach((element) {
        return quizExerciseList.add(QuizExercise.fromJson(element.data()));
      });
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

  Future<QuizExercise?> getById(String quizId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('task_set')
          .doc(quizId)
          .get();

      return QuizExercise.fromJson(result as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
