import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/quiz_participation.dart';
import '../../../../models/weekly_quiz.dart';
import '../../../../services/firebase_service.dart';
import '../../../../services/quiz_service.dart';

part 'quiz_registration_event.dart';
part 'quiz_registration_state.dart';

class QuizRegistrationCubit extends Cubit<QuizRegistrationState> {
  QuizRegistrationCubit() : super(QuizRegistrationInitialState());

  Future<void> registerParticipant(
    String selectedLevel,
    String selectedWeek,
  ) async {
    try {
      emit(QuizRegistrationLoading());
      await QuizService().registerParticipant(selectedWeek, selectedLevel);

      emit(const QuizRegistrationSuccess('success'));
    } catch (e) {
      emit(RunningWeeklyQuizFailed(e.toString()));
    }
  }

  Future<void> fetchParticipantWeeklyQuiz() async {
    try {
      final participantUid = FirebaseService.auth().currentUser!.uid;
      final participantWeeklyQuizzes = await QuizService()
          .getRunningWeeklyQuizByParticipantUid(participantUid);

      emit(GetParticipantWeeklyQuizSuccess(participantWeeklyQuizzes));
    } catch (e) {
      emit(GetParticipantWeeklyQuizFailed(e.toString()));
    }
  }

  // Future<void> fetchRunningQuizTasks(String level) async {
  //   try {
  //     final participantWeeklyQuizzes =
  //         await QuizService().getWeeklyQuizByWeek('running_weekly_quiz');

  //     final tasks = await QuizService().fetchWeeklyQuizTaskSet(
  //       participantWeeklyQuizzes.problems[level][0].toString(),
  //     );

  //     emit(GetRunningQuizTasksSuccess(tasks));
  //   } catch (e) {
  //     emit(GetParticipantWeeklyQuizFailed(e.toString()));
  //   }
  // }
}
