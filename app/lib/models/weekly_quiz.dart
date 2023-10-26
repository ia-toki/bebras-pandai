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

  factory WeeklyQuizModel.fromJson(
    String id,
    Map<String, dynamic> json,
  ) =>
      WeeklyQuizModel(
        id: id,
        title: json['title'] as String,
        created_at: json['created_at'] as String,
        duration_minute: json['duration_minute'] as Map<String, dynamic>,
        end_at: json['end_at'] as String,
        max_attempts: json['max_attempts'] as Map<String, dynamic>,
        problems: json['tasks'] as Map<String, dynamic>,
        sponsors: json['sponsors'] as Map<String, dynamic>,
        start_at: json['start_at'] as String,
      );

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
