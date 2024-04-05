import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/quiz_participation.dart';
import '../../../../services/firebase_service.dart';
import '../../../../services/quiz_service.dart';

part 'quiz_history_state.dart';

class QuizHistoryCubit extends Cubit<QuizHistoryState> {
  QuizHistoryCubit() : super(QuizHistoryInitialState());

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
}
