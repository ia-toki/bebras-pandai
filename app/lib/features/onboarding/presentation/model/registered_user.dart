class RegisteredUserModel {
  final String email;
  final String name;
  final DateTime birth_date;
  final String school;
  final String province;
  final String bebras_biro;

  RegisteredUserModel({
    required this.email,
    required this.name,
    required this.birth_date,
    required this.school,
    required this.province,
    required this.bebras_biro,
  });

  factory RegisteredUserModel.fromJson(Map<String, dynamic> json) {
    return RegisteredUserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      birth_date: json['birth_date'] as DateTime,
      school: json['school'] as String,
      province: json['province'] as String,
      bebras_biro: json['bebras_biro'] as String
    );
  }
}