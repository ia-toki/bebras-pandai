part of 'user_initialization_bloc.dart';

abstract class UserInitializationState extends Equatable {}

class UserInitializationInitial extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UserInitializationLoading extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UserError extends UserInitializationState {
  final String error;

  UserError(this.error);
  @override
  List<Object> get props => [error];
}

class UserAuthenticated extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UserUnauthenticated extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UserUnregistered extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UserRegistered extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UpdateAvailable extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UserGetDataLoading extends UserInitializationState {
  @override
  List<Object> get props => [];
}

class UserDataUploaded extends UserInitializationState {
  @override
  List<Object> get props => [];
}

// class UserDataLoaded extends UserInitializationState {
//   final RegisteredUserModel userData;
//   UserDataLoaded(this.userDataList);
//   @override
//   List<Object?> get props => [userDataList];
// }
