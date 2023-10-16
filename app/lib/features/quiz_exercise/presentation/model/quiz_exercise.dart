import 'description.dart';
import 'questions.dart';

class QuizExercise {
  final String id;
  final String country;
  final String challengeGroup;
  final String title;
  final String type;
  final String source;
  final Description description;
  final Question question;

  QuizExercise({
    required this.id,
    required this.country,
    required this.challengeGroup,
    required this.title,
    required this.source,
    required this.type,
    required this.description,
    required this.question,
  });

  factory QuizExercise.fromJson(Map<String, dynamic> json) {
    return QuizExercise(
      id: json['id'] as String,
      country: json['country'] as String,
      challengeGroup: json['challenge_group'] as String,
      title: json['title'] as String,
      source: json['source'] as String,
      type: json['type'] as String,
      description:
          Description.fromJson(json['description'] as Map<String, dynamic>),
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
    );
  }
}
