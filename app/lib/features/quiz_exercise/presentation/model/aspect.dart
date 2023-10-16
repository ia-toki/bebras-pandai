class Aspect {
  final String content;
  final String label;
  Aspect({required this.content, required this.label});

  factory Aspect.fromJson(Map<String, dynamic> json) {
    return Aspect(
      content: json['content'] as String,
      label: json['label'] as String,
    );
  }
}
