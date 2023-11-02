class Explanation {
  final String content;

  Explanation({required this.content});

  factory Explanation.fromJson(Map<String, dynamic> json) {
    return Explanation(
      content: json['content'] as String,
    );
  }
}
