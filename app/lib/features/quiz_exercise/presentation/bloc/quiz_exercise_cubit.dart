import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/weekly_quiz.dart';
import '../../../../services/quiz_service.dart';
import '../model/quiz_exercise.dart';
import '../model/quiz_exercise_answer.dart';
import '../model/quiz_exercise_attempt.dart';
import '../repositories/quiz_exercise.dart';

part 'quiz_exercise_event.dart';
part 'quiz_exercise_state.dart';

class QuizExerciseCubit extends Cubit<QuizExerciseState> {
  QuizExerciseCubit() : super(QuizExerciseInitialState());

  late WeeklyQuiz quiz;
  late QuizExercise currentProblem;
  int currentProblemIndex = 0;
  late List<String> problemIdList;
  late QuizExerciseAttempt attempt;
  late String quizParticipantId;
  late String challengeGroup;
  late int remainingDuration;

  late QuizService quizService;
  late QuizExerciseRepository quizExerciseRepository;

  FutureOr<void> fetchQuizExercise(
      {String? quizId,
      String? quizParticipantId,
      String? challengeGroup}) async {
    try {
      this.quizService = QuizService();
      this.quizExerciseRepository = QuizExerciseRepository();

      emit(QuizExerciseLoading());
      if (quizId == null) {
        throw Exception('Quiz Id null');
      }
      if (quizParticipantId == null) {
        throw Exception('Quiz Participant Id null');
      }
      if (challengeGroup == null) {
        throw Exception('Challenge Group null');
      }
      this.quizParticipantId = quizParticipantId;
      this.challengeGroup = challengeGroup;

      quiz = await quizService.getQuiz(quizId);

      var _problemIdList = quiz.problems[challengeGroup];
      if (_problemIdList == null) {
        throw Exception('Challenge Group not found');
      }
      problemIdList = _problemIdList;
      if (problemIdList == null) {
        throw Exception('Task for selected Challenge Group not found');
      }
      if (problemIdList.isEmpty) {
        throw Exception('Problem Set empty');
      }

      var weeklyQuizParticipant = await quizService.getWeeklyQuizParticipant(
          quizParticipantId: quizParticipantId);
      if (weeklyQuizParticipant.attempts.isEmpty) {
        attempt = QuizExerciseAttempt(
            startAt: DateTime.now(),
            totalBlank: problemIdList.length,
            totalCorrect: 0,
            totalIncorrect: 0,
            answers: []);
      }

      currentProblem =
          await quizExerciseRepository.getQuizExercise(problemIdList.first);

      final duration = quiz.duration_minute[challengeGroup];
      if (duration == null) {
        throw Exception('Duration for selected Challenge Group not found');
      }
      remainingDuration = duration * 60;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingDuration > 0) {
          remainingDuration--;
          emit(QuizExerciseShow(
              quiz, currentProblem, Duration(seconds: remainingDuration)));
        } else {
          emit(QuizExerciseFailed('Duration Ends'));
        }
      });
      emit(QuizExerciseShow(
          quiz, currentProblem, Duration(seconds: remainingDuration)));
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }

  FutureOr<void> submitAnswer(String answerId) async {
    try {
      var verdict = 'INCORRECT';
      if (currentProblem.answer.correctAnswer.contains(answerId)) {
        verdict = 'CORRECT';
      }
      attempt.answers?.add(QuizExerciseAnswer(
          answer: answerId,
          correctAnswer: currentProblem.answer.correctAnswer,
          taskChallengeGroup: currentProblem.challengeGroup,
          taskId: currentProblem.id,
          verdict: verdict));

      if (verdict == 'CORRECT') {
        attempt.totalCorrect++;
        attempt.totalBlank--;
      } else {
        attempt.totalIncorrect++;
        attempt.totalBlank--;
      }

      currentProblemIndex++;

      if (currentProblemIndex < problemIdList.length) {
        currentProblem = await quizExerciseRepository
            .getQuizExercise(problemIdList[currentProblemIndex]);
        emit(QuizExerciseShow(
            quiz, currentProblem, Duration(seconds: remainingDuration)));
      } else {
        await quizExerciseRepository.insertQuizExerciseAttempt(
            quizParticipantId, attempt);
        emit(QuizExerciseFinished(attempt));
      }
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }
}
