// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import '../features/quiz_exercise/presentation/model/quiz_exercise_attempt.dart';

class WeeklyQuizParticipation extends Equatable {
  final String id;
  final String quiz_title;
  final String user_name;
  final String user_uid;
  final String challenge_group;
  final String quiz_end_at;
  final String quiz_start_at;
  final String quiz_id;
  final List<QuizExerciseAttempt> attempts;
  final int quiz_max_attempts;

  const WeeklyQuizParticipation({
    this.id = '',
    this.quiz_title = '',
    this.user_name = '',
    this.user_uid = '',
    this.challenge_group = '',
    this.quiz_end_at = '',
    this.quiz_start_at = '',
    this.quiz_id = '',
    this.quiz_max_attempts = 0,
    this.attempts = const [],
  });

  factory WeeklyQuizParticipation.fromJson(
    String id,
    Map<String, dynamic> json,
  ) {
    var attempts = json['attempts'];
    return WeeklyQuizParticipation(
      id: id,
      quiz_start_at: json['quiz_start_at'] as String,
      quiz_title: json['quiz_title'] as String,
      user_name: json['user_name'] as String,
      user_uid: json['user_uid'] as String,
      challenge_group: json['challenge_group'] as String,
      quiz_end_at: json['quiz_end_at'] as String,
      quiz_id: json['quiz_id'] as String,
      quiz_max_attempts: json['quiz_max_attempts'] as int,
      attempts: attempts == null
          ? []
          : (attempts as List)
              .map((i) =>
                  QuizExerciseAttempt.fromJson(i as Map<String, dynamic>))
              .toList(),
    );
  }

  @override
  List<Object> get props => [
        user_name,
        user_uid,
        challenge_group,
        quiz_end_at,
        quiz_start_at,
        quiz_id,
        quiz_max_attempts,
        attempts,
      ];
}
