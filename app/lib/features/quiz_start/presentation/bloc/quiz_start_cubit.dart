import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/quiz_participation.dart';
import '../../../../models/weekly_quiz.dart';
import '../../../../services/quiz_service.dart';

part 'quiz_start_state.dart';

class QuizStartCubit extends Cubit<QuizStartState> {
  QuizStartCubit() : super(QuizStartInitial());

  bool agreement = false;
  late WeeklyQuiz quiz;
  late WeeklyQuizParticipation participation;

  Future<void> initialize(String? quizParticipantId) async {
    try {
      final quizService = QuizService();

      if (quizParticipantId == null) {
        throw Exception('QuizParticipantId is null');
      }

      participation = await quizService.getWeeklyQuizParticipant(
          quizParticipantId: quizParticipantId);

      quiz = await quizService.getWeeklyQuizById(participation.quiz_id);

      emit(QuizStartSuccess(
          participation: participation, quiz: quiz, agreement: agreement));
    } catch (e) {
      emit(QuizStartFailed(e.toString()));
    }
  }

  void setAgreement({required bool value}) {
    agreement = value;
    emit(QuizStartSuccess(
        participation: participation, quiz: quiz, agreement: agreement));
  }
}
