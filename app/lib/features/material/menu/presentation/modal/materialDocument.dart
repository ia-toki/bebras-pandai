class MaterialDocument {

  final String? challenge_group;
  final String? description;
  final String? file_format;
  final bool is_printable;
  final List<String?>? source_urls;
  final String? staging_url;
  final String? title;
  final String? url;

  MaterialDocument({
    this.challenge_group,
    this.description,
    this.file_format,
    this.is_printable = false,
    this.source_urls,
    this.staging_url,
    this.title,
    this.url
  });

  factory MaterialDocument.fromJson(dynamic json) {
    return MaterialDocument(
        challenge_group: json.data()['challenge_group'].toString(),
        description: json.data()['description'].toString(),
        file_format: json.data()['file_format'].toString(),
        is_printable: json.data()['is_printable'] as bool,
        source_urls: json.data()['source_urls'] as List<String?>?,
        staging_url: json.data()['staging_url'].toString(),
        title: json.data()['title'].toString(),
        url: json.data()['url'].toString()
    );
  }
}