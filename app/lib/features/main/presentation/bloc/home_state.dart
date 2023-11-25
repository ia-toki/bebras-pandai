part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final RegisteredUserModel user;

  HomeSuccess(
    this.user,
  );

  List<Object> get props => [user];
}

class HomeFailed extends HomeState {
  final String error;

  HomeFailed(this.error);
  List<Object> get props => [error];
}
