// import 'quiz_exercise_answer.dart';

class QuizExerciseAttempt {
  DateTime startAt;
  DateTime? endAt;
  DateTime? uploadedAt;
  int totalBlank;
  int totalCorrect;
  int totalIncorrect;
  int? score;
  List<dynamic>? answers;

  QuizExerciseAttempt({
    required this.startAt,
    required this.totalBlank,
    required this.totalCorrect,
    required this.totalIncorrect,
    this.endAt,
    this.uploadedAt,
    this.score,
    this.answers,
  });

  factory QuizExerciseAttempt.fromJson(
    Map<String, dynamic> json,
  ) =>
      QuizExerciseAttempt(
        startAt: json['start_at'].toDate() as DateTime,
        endAt: (json['end_at'] == null)
            ? null
            : json['end_at'].toDate() as DateTime,
        uploadedAt: (json['uploaded_at'] == null)
            ? null
            : json['uploaded_at'].toDate() as DateTime,
        totalBlank: json['n_answer_blank'] as int,
        totalCorrect: json['n_answer_correct'] as int,
        totalIncorrect: json['n_answer_incorrect'] as int,
        score: json['score'] as int,
        answers: json['answers'] as List<dynamic>,
      );

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
