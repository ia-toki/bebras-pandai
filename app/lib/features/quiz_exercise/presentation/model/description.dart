class Description {
  final String content;
  Description({required this.content});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(content: json['content'] as String);
  }
}
