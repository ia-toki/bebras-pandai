// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class RegisteredParticipantModel extends Equatable {
  final String id;
  final String quiz_title;
  final String user_name;
  final String user_uid;
  final String challenge_group;
  final String created_at;
  final String quiz_end_at;
  final String quiz_start_at;
  final String quiz_id;
  final List<dynamic> attempts;
  final int quiz_max_attempts;

  const RegisteredParticipantModel({
    this.id = '',
    this.quiz_title = '',
    this.user_name = '',
    this.user_uid = '',
    this.challenge_group = '',
    this.created_at = '',
    this.quiz_end_at = '',
    this.quiz_start_at = '',
    this.quiz_id = '',
    this.quiz_max_attempts = 0,
    this.attempts = const [],
  });

  factory RegisteredParticipantModel.fromJson(
    String id,
    Map<String, dynamic> json,
  ) =>
      RegisteredParticipantModel(
        id: id,
        quiz_start_at: json['quiz_start_at'] as String,
        quiz_title: json['quiz_title'] as String,
        user_name: json['user_name'] as String,
        created_at: json['created_at'] as String,
        user_uid: json['user_uid'] as String,
        challenge_group: json['challenge_group'] as String,
        quiz_end_at: json['quiz_end_at'] as String,
        quiz_id: json['quiz_id'] as String,
        quiz_max_attempts: json['quiz_max_attempts'] as int,
        attempts: json['attempts'] as List<dynamic>,
      );

  @override
  List<Object> get props => [
        user_name,
        user_uid,
        challenge_group,
        created_at,
        quiz_end_at,
        quiz_start_at,
        quiz_id,
        quiz_max_attempts,
      ];
}
