// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class RegisteredParticipantModel extends Equatable {
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
