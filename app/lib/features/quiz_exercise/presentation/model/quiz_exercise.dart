import 'answer.dart';
import 'description.dart';
import 'questions.dart';

class QuizExerciseBase {
  final String id;
  final String challengeGroup;
  final String title;
  final String? status;

  QuizExerciseBase({
    required this.id,
    required this.challengeGroup,
    required this.title,
    this.status
  });

  factory QuizExerciseBase.fromJson(Map<String, dynamic> json) {
    return QuizExerciseBase(
      id: json['id'] as String,
      challengeGroup: json['challenge_group'] as String,
      title: json['title'] as String,
      status: json['status'] as String?,
    );
  }
}

class QuizExercise extends QuizExerciseBase {
  // using inheritance pattern for properties consistency,
  // make error if forgot to update this class while the parent is edited
  final String country;
  final String type;
  final String source;
  final Description description;
  final Question question;
  final Answer answer;

  QuizExercise({
    required super.id,
    required super.challengeGroup,
    required super.title,
    required super.status,
    required this.country,
    required this.source,
    required this.type,
    required this.description,
    required this.question,
    required this.answer,
  });

  factory QuizExercise.fromJson(Map<String, dynamic> json) {
    return QuizExercise(
      id: json['id'] as String,
      challengeGroup: json['challenge_group'] as String,
      title: json['title'] as String,
      status: json['status'] as String?,
      country: json['country'] as String,
      source: json['source'] as String,
      type: json['type'] as String,
      description:
          Description.fromJson(json['description'] as Map<String, dynamic>),
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
      answer: Answer.fromJson(json['answer'] as Map<String, dynamic>),
    );
  }
}
