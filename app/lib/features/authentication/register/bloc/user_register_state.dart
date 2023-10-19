part of 'user_register_bloc.dart';

class RegisterFormState extends Equatable {

  const RegisterFormState({
    this.email = const BlocFormItem(error: 'Mohon mengisi e-mail terlebih dahulu.'),
    this.name = const BlocFormItem(error: 'Mohon mengisi nama terlebih dahulu.'),
    this.birth_date = const BlocFormItem(error: 'Mohon mengisi tanggal lahir terlebih dahulu.'),
    this.school = const BlocFormItem(error: 'Mohon mengisi nama sekolah terlebih dahulu.'),
    this.province = const BlocFormItem(error: 'Mohon mengisi nama provinsi terlebih dahulu.'),
    this.bebras_biro = const BlocFormItem(error: 'Mohon mengisi biro bebras terlebih dahulu.'),
    this.formKey,
  });

  final BlocFormItem email;
  final BlocFormItem name;
  final BlocFormItem birth_date;
  final BlocFormItem school;
  final BlocFormItem province;
  final BlocFormItem bebras_biro;
  final GlobalKey<FormState>? formKey;

  RegisterFormState copyWith({
    BlocFormItem? email,
    BlocFormItem? name,
    BlocFormItem? birth_date,
    BlocFormItem? school,
    BlocFormItem? province,
    BlocFormItem? bebras_biro,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterFormState(
      email: email ?? this.email,
      name: name ?? this.name,
      birth_date: birth_date ?? this.birth_date,
      school: school ?? this.school,
      province: province ?? this.province,
      bebras_biro: bebras_biro ?? this.bebras_biro,
      formKey: formKey,
    );
  }

  @override
  List<Object> get props => [email, name, birth_date, school, province, bebras_biro];
}

enum FormStatus { none, inProgress, valid, invalid }

class UserRegisterLoadingState extends RegisterFormState {
  @override
  List<Object> get props => [];
}

class UserRegisterSuccessState extends RegisterFormState {
  @override
  List<Object> get props => [];
}