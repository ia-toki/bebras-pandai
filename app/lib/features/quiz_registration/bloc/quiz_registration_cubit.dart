import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/registered_participant.dart';
import '../../../models/weekly_quiz.dart';
import '../../../services/quiz_service.dart';

part 'quiz_registration_state.dart';
part 'quiz_registration_event.dart';

class QuizRegistrationCubit extends Cubit<QuizRegistrationState> {
  QuizRegistrationCubit() : super(QuizRegistrationInitialState());

  Future<void> registerParticipant(
      String selectedLevel, String selectedWeek) async {
    try {
      emit(QuizRegistrationLoading());
      await QuizService().registerParticipant(selectedWeek, selectedLevel);

      emit(const QuizRegistrationSuccess('success'));
    } catch (e) {
      print(e.toString());
      emit(RunningWeeklyQuizFailed(e.toString()));
    }
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
