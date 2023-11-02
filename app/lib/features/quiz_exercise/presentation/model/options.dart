class Options {
  final String content;
  final String id;
  Options({required this.content, required this.id});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      content: json['content'] as String,
      id: json['id'] as String,
    );
  }
}
