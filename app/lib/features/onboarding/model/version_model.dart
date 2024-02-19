class VersionModel {
  final String version;

  VersionModel({
    required this.version,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
      version: json['version'].toString(), 
    );
  }
}
