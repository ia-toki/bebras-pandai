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

  late WeeklyQuizModel quiz;
  late List<QuizExercise> problemList;
  int currentProblemIndex = 0;
  late QuizExerciseAttempt attempt;
  late String quizParticipantId;
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

      quiz = await quizService.getQuiz(quizId);

      var problemIdList = quiz.problems[challengeGroup];
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

      problemList =
          await quizExerciseRepository.getListQuizExercise(problemIdList);
      emit(QuizExerciseShow(problemList.first));
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }

  FutureOr<void> submitAnswer(String answerId) async {
    var verdict = 'INCORRECT';
    if (problemList[currentProblemIndex]
        .answer
        .correctAnswer
        .contains(answerId)) {
      verdict = 'CORRECT';
    }
    attempt.answers?.add(QuizExerciseAnswer(
        answer: answerId,
        correctAnswer: problemList[currentProblemIndex].answer.correctAnswer,
        taskChallengeGroup: problemList[currentProblemIndex].challengeGroup,
        taskId: problemList[currentProblemIndex].id,
        verdict: verdict));

    if (verdict == 'CORRECT') {
      attempt.totalCorrect++;
      attempt.totalBlank--;
    } else {
      attempt.totalIncorrect++;
      attempt.totalBlank--;
    }

    currentProblemIndex++;

    if (currentProblemIndex < problemList.length) {
      emit(QuizExerciseShow(problemList[currentProblemIndex]));
    } else {
      try {
        await quizExerciseRepository.insertQuizExerciseAttempt(
            quizParticipantId, attempt);
        emit(QuizExerciseFinished(attempt));
      } catch (e) {
        emit(QuizExerciseFailed(e.toString()));
      }
    }
  }
}
