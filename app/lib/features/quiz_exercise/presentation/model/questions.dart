import 'options.dart';

class Question {
  final String content;
  final List<Options> options;

  Question({required this.content, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      content: json['content'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => Options.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
