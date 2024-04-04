import 'aspect.dart';
import 'explanation.dart';

class Answer {
  final Aspect aspect;
  final List<String> correctAnswer;
  final Explanation explanation;

  Answer({
    required this.aspect,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    var correctAnswer = json['correct_answer'];
    return Answer(
      aspect: Aspect.fromJson(json['aspect'] as Map<String, dynamic>),
      correctAnswer: correctAnswer == null
          ? []
          : (correctAnswer as List<dynamic>).map((e) => e.toString()).toList(),
      explanation:
          Explanation.fromJson(json['explanation'] as Map<String, dynamic>),
    );
  }
}
