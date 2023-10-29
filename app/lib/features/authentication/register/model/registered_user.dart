class RegisteredUserModel {
  final String email;
  final String name;
  final String birthDate;
  final String school;
  final String province;
  final String bebrasBiro;

  RegisteredUserModel({
    required this.email,
    required this.name,
    required this.birthDate,
    required this.school,
    required this.province,
    required this.bebrasBiro,
  });

  factory RegisteredUserModel.fromJson(dynamic json) {
    return RegisteredUserModel(
      email: json.data()['email'].toString(),
      name: json.data()['name'].toString(),
      birthDate: json.data()['birth_date'].toString(),
      school: json.data()['school'].toString(),
      province: json.data()['province'].toString(),
      bebrasBiro: json.data()['bebras_biro'].toString(),
    );
  }
}
