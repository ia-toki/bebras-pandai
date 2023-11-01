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
}
