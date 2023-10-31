part of 'user_initialization_bloc.dart';

abstract class UserInitializationEvent extends Equatable {
  const UserInitializationEvent();

  @override
  List<Object> get props => [];
}

class OnboardingAuthEvent extends UserInitializationEvent {}

class CheckRegisteredUser extends UserInitializationEvent {}

class CreateUserData extends UserInitializationEvent {
  final String email;
  final String name;
  final String birthDate;
  final String school;
  final String province;
  final String bebrasBiro;

  const CreateUserData(
    this.email,
    this.name,
    this.birthDate,
    this.school,
    this.province,
    this.bebrasBiro,
  );
}

class GetUserData extends UserInitializationEvent {
  const GetUserData();
}
