part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MainSuccess extends MainState {
  final Map<String, dynamic> userData;

  MainSuccess(
    this.userData,
  );

  @override
  List<Object> get props => [userData];
}

class MainFailed extends MainState {
  final String error;

  MainFailed(this.error);
  @override
  List<Object> get props => [error];
}
