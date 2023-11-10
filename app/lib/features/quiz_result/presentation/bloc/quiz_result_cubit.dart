// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../services/quiz_service.dart';
import '../../../quiz_exercise/presentation/model/quiz_exercise_attempt.dart';

part 'quiz_result_state.dart';

class QuizResultCubit extends Cubit<QuizResultState> {
  QuizResultCubit() : super(QuizResultInitial());

  FutureOr<void> initialize(String? quizParticipantId) async {
    try {
      final quizService = QuizService();

      if (quizParticipantId == null) {
        throw Exception('QuizParticipantId is null');
      }

      final quizParticipation = await quizService.getWeeklyQuizParticipant(
          quizParticipantId: quizParticipantId);

      if (quizParticipation.attempts.isEmpty) {
        emit(QuizResultNotAvailable());
      } else {
        emit(QuizResultAvailable(quizParticipation.attempts.last));
      }
    } catch (e) {
      emit(QuizResultFailed(e.toString()));
    }
  }
}
