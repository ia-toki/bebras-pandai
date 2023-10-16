import 'options.dart';

class Question {
  final String content;
  final List<Options> options;

  Question({required this.content, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      content: json['content'] as String,
      options: json['options'].cast<Map<String, dynamic>>() as List<Options>,
    );
  }
}
