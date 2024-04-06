import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/quiz_participation.dart';
import '../../../../services/firebase_service.dart';
import '../../../../services/quiz_service.dart';

part 'quiz_registration_state.dart';

class QuizRegistrationCubit extends Cubit<QuizRegistrationState> {
  QuizRegistrationCubit() : super(QuizRegistrationInitialState());
  QuizService quizService = QuizService();

  Future<void> registerParticipant(
    String selectedLevel,
    String selectedWeek,
  ) async {
    try {
      emit(QuizRegistrationLoading());
      await quizService.registerParticipant(selectedWeek, selectedLevel);
      final participantWeeklyQuizzes =
          await quizService.getRunningWeeklyQuizByParticipantUid(
              FirebaseService.auth().currentUser!.uid);

      emit(QuizRegistrationSuccess(participantWeeklyQuizzes));
    } catch (e) {
      emit(QuizRegistrationFailed(e.toString()));
    }
  }

  Future<void> fetchParticipantWeeklyQuiz() async {
    try {
      emit(QuizRegistrationLoading());
      final participantWeeklyQuizzes =
          await quizService.getRunningWeeklyQuizByParticipantUid(
              FirebaseService.auth().currentUser!.uid);

      emit(QuizRegistrationSuccess(participantWeeklyQuizzes));
    } catch (e) {
      emit(QuizRegistrationFailed(e.toString()));
    }
  }
}
