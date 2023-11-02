import 'quiz_exercise_answer.dart';

class QuizExerciseAttempt {
  DateTime startAt;
  DateTime? endAt;
  DateTime? uploadedAt;
  int totalBlank;
  int totalCorrect;
  int totalIncorrect;
  int? score;
  List<QuizExerciseAnswer>? answers;

  QuizExerciseAttempt(
      {required this.startAt,
      this.endAt,
      this.uploadedAt,
      required this.totalBlank,
      required this.totalCorrect,
      required this.totalIncorrect,
      this.score,
      this.answers});

  Map<String, Object?> toJson() {
    return {
      'start_at': startAt,
      'end_at': endAt,
      'uploaded_at': uploadedAt,
      'n_answer_blank': totalBlank,
      'n_answer_correct': totalCorrect,
      'n_answer_incorrect': totalIncorrect,
      'score': score,
      'answers': answers?.map((e) => e.toJson()).toList(),
    };
  }
}
