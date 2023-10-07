import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_registration_state.dart';
part 'quiz_registration_event.dart';

class QuizRegistrationCubit extends Cubit<QuizRegistrationState> {
  QuizRegistrationCubit() : super(QuizRegistrationInitialState());

  void selectWeek(String selectedWeek) {
    emit(QuizRegistrationLoading());

    emit(QuizRegistrationWeekSelected(selectedWeek));
  }
}
