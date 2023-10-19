import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/weekly_quiz.dart';
import '../../../services/quiz_service.dart';

part 'quiz_registration_state.dart';
part 'quiz_registration_event.dart';

class QuizRegistrationCubit extends Cubit<QuizRegistrationState> {
  QuizRegistrationCubit() : super(QuizRegistrationInitialState());

  void selectWeek(String selectedWeek) {
    emit(QuizRegistrationLoading());

    emit(QuizRegistrationWeekSelected(selectedWeek));
  }

  void selectLevel(String selectedLevel) {
    emit(QuizRegistrationLoading());

    emit(QuizRegistrationLevelSelected(selectedLevel));
  }

  Future<void> fetchRunningWeeklyQuiz() async {
    try {
      emit(QuizRegistrationLoading());
      final runningWeeklyQuiz =
          await QuizService().fetchWeeklyQuiz('running_weekly_quiz');
      print(runningWeeklyQuiz);

      emit(RunningWeeklyQuizSuccess(runningWeeklyQuiz));
    } catch (e) {
      emit(RunningWeeklyQuizFailed(e.toString()));
    }
  }
}
