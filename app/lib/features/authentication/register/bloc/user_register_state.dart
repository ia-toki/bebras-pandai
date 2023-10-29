part of 'user_register_bloc.dart';

class RegisterFormState extends Equatable {
  const RegisterFormState({
    this.email =
        const BlocFormItem(error: 'Mohon mengisi e-mail terlebih dahulu.'),
    this.name =
        const BlocFormItem(error: 'Mohon mengisi nama terlebih dahulu.'),
    this.birthDate = const BlocFormItem(
      error: 'Mohon mengisi tanggal lahir terlebih dahulu.',
    ),
    this.school = const BlocFormItem(
      error: 'Mohon mengisi nama sekolah terlebih dahulu.',
    ),
    this.province = const BlocFormItem(
      error: 'Mohon mengisi nama provinsi terlebih dahulu.',
    ),
    this.bebrasBiro =
        const BlocFormItem(error: 'Mohon mengisi biro bebras terlebih dahulu.'),
    this.formKey,
  });

  final BlocFormItem email;
  final BlocFormItem name;
  final BlocFormItem birthDate;
  final BlocFormItem school;
  final BlocFormItem province;
  final BlocFormItem bebrasBiro;
  final GlobalKey<FormState>? formKey;

  RegisterFormState copyWith({
    BlocFormItem? email,
    BlocFormItem? name,
    BlocFormItem? birthDate,
    BlocFormItem? school,
    BlocFormItem? province,
    BlocFormItem? bebrasBiro,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterFormState(
      email: email ?? this.email,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      school: school ?? this.school,
      province: province ?? this.province,
      bebrasBiro: bebrasBiro ?? this.bebrasBiro,
      formKey: formKey,
    );
  }

  @override
  List<Object> get props =>
      [email, name, birthDate, school, province, bebrasBiro];
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
