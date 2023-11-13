class RegisteredUserModel {
  final String email;
  final String name;
  final String birthDate;
  final String school;
  final String province;
  final String bebrasBiro;
  final bool isAdmin;

  RegisteredUserModel({
    required this.email,
    required this.name,
    required this.birthDate,
    required this.school,
    required this.province,
    required this.bebrasBiro,
    required this.isAdmin,
  });

  factory RegisteredUserModel.fromJson(Map<String, dynamic> json) {
    return RegisteredUserModel(
      email: json['email'].toString(),
      name: json['name'].toString(),
      birthDate: json['birth_date'].toString(),
      school: json['school'].toString(),
      province: json['province'].toString(),
      bebrasBiro: json['bebras_biro'].toString(),
      isAdmin: json['is_admin'] != null && json['is_admin']! as bool,
    );
  }
}
