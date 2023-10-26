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
  final String birth_date;
  final String school;
  final String province;
  final String bebras_biro;

  const CreateUserData(
      this.email,
      this.name,
      this.birth_date,
      this.school,
      this.province,
      this.bebras_biro,
      );
}

class GetUserData extends UserInitializationEvent {
  const GetUserData();
}
