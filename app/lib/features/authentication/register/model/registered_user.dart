class RegisteredUserModel {
  final String email;
  final String name;
  final String birth_date;
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

  factory RegisteredUserModel.fromJson(dynamic json) {
    return RegisteredUserModel(
      email: json.data()['email'].toString(),
      name: json.data()['name'].toString(),
      birth_date: json.data()['birth_date'].toString(),
      school: json.data()['school'].toString(),
      province: json.data()['province'].toString(),
      bebras_biro: json.data()['bebras_biro'].toString(),
    );
  }
}