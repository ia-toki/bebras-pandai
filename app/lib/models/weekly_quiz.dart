// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class WeeklyQuizModel extends Equatable {
  final String id;
  final String title;
  final String created_at;
  final Map<String, dynamic> duration_minute;
  final String end_at;
  final Map<String, dynamic> max_attempts;
  final Map<String, dynamic> problems;
  final Map<String, dynamic> sponsors;
  final String start_at;

  const WeeklyQuizModel({
    required this.id,
    required this.title,
    required this.created_at,
    required this.duration_minute,
    required this.end_at,
    required this.max_attempts,
    required this.problems,
    required this.sponsors,
    required this.start_at,
  });

  @override
  List<Object> get props => [
        id,
        title,
        created_at,
        duration_minute,
        end_at,
        max_attempts,
        problems,
        sponsors,
        start_at,
      ];
}
