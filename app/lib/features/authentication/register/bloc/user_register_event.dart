part of 'user_register_bloc.dart';

abstract class UserRegisterEvent extends Equatable {
  const UserRegisterEvent();

  @override
  List<Object> get props => [];
}

class FormSubmitEvent extends UserRegisterEvent {
  const FormSubmitEvent();
}

class FormResetEvent extends UserRegisterEvent {
  const FormResetEvent();
}

class InitialValueEvent extends UserRegisterEvent {
  const InitialValueEvent();
}

class InitEvent extends UserRegisterEvent {
  const InitEvent();
}

class EmailEvent extends UserRegisterEvent {
  const EmailEvent({required this.email});
  final BlocFormItem email;
  @override
  List<Object> get props => [email];
}

class NameEvent extends UserRegisterEvent {
  const NameEvent({required this.name});
  final BlocFormItem name;
  @override
  List<Object> get props => [name];
}

class BirthDateEvent extends UserRegisterEvent {
  const BirthDateEvent({required this.birthDate});
  final BlocFormItem birthDate;
  @override
  List<Object> get props => [birthDate];
}

class SchoolEvent extends UserRegisterEvent {
  const SchoolEvent({required this.school});
  final BlocFormItem school;
  @override
  List<Object> get props => [school];
}

class ProvinceEvent extends UserRegisterEvent {
  const ProvinceEvent({required this.province});
  final BlocFormItem province;
  @override
  List<Object> get props => [province];
}

class BebrasBiroEvent extends UserRegisterEvent {
  const BebrasBiroEvent({required this.bebrasBiro});
  final BlocFormItem bebrasBiro;
  @override
  List<Object> get props => [bebrasBiro];
}
