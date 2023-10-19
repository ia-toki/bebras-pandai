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
  final int quiz_max_attempts;

  const RegisteredParticipantModel({
    required this.user_name,
    required this.user_uid,
    required this.challenge_group,
    required this.created_at,
    required this.quiz_end_at,
    required this.quiz_start_at,
    required this.quiz_id,
    required this.quiz_max_attempts,
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
