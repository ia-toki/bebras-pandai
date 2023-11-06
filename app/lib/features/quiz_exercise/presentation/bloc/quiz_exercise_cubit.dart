// ignore_for_file: lines_longer_than_80_chars

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

  String selectedAnswer = '';
  String shortAnswer = '';
  late int remainingDuration;

  late QuizService quizService;
  late QuizExerciseRepository quizExerciseRepository;

  FutureOr<void> fetchQuizExercise({
    String? quizId,
    String? quizParticipantId,
    String? challengeGroup,
  }) async {
    try {
      quizService = QuizService();
      quizExerciseRepository = QuizExerciseRepository();

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

      quiz = await quizService.getWeeklyQuizById(quizId);

      problemIdList = quiz.problems[challengeGroup]!;
      // ignore: unnecessary_null_comparison
      if (problemIdList == null) {
        throw Exception('Task set for `$challengeGroup` is not found');
      }
      if (problemIdList.isEmpty) {
        throw Exception('Task set for `$challengeGroup` is empty');
      }

      // TODO(someone): fix the check logic later
      // final weeklyQuizParticipant = await quizService.getWeeklyQuizParticipant(
      //   quizParticipantId: quizParticipantId,
      // );
      //
      // if (weeklyQuizParticipant.attempts.isEmpty) {
      attempt = QuizExerciseAttempt(
        startAt: DateTime.now(),
        totalBlank: problemIdList.length,
        totalCorrect: 0,
        totalIncorrect: 0,
        answers: [],
      );

      currentProblem =
          await quizExerciseRepository.getQuizExercise(problemIdList.first);

      final duration = quiz.duration_minute[challengeGroup];
      if (duration == null) {
        throw Exception('Duration for selected Challenge Group not found');
      }
      remainingDuration = duration * 60;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state is! QuizExerciseShow) {
          timer.cancel();
        } else if (remainingDuration > 0) {
          remainingDuration--;
          emit(
            QuizExerciseShow(
              quiz: quiz,
              quizExercise: currentProblem,
              remainingDuration: Duration(seconds: remainingDuration),
              selectedAnswer: selectedAnswer,
            ),
          );
        } else {
          timer.cancel();
          emit(const QuizExerciseFailed('Duration Ends'));
        }
      });
      emit(
        QuizExerciseShow(
          quiz: quiz,
          quizExercise: currentProblem,
          remainingDuration: Duration(seconds: remainingDuration),
          selectedAnswer: selectedAnswer,
        ),
      );
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }

  void selectAnswer(String answerId) {
    selectedAnswer = answerId;
    emit(
      QuizExerciseShow(
        quiz: quiz,
        quizExercise: currentProblem,
        remainingDuration: Duration(seconds: remainingDuration),
        selectedAnswer: selectedAnswer,
      ),
    );
  }

  void fillAnswer(String answer) {
    shortAnswer = answer;
    emit(
      QuizExerciseShow(
        quiz: quiz,
        quizExercise: currentProblem,
        remainingDuration: Duration(seconds: remainingDuration),
        shortAnswer: answer,
      ),
    );
  }

  FutureOr<void> submitAnswer() async {
    if ((currentProblem.type == 'MULTIPLE_CHOICE' && selectedAnswer == '') ||
        (currentProblem.type == 'SHORT_ANSWER') && shortAnswer == '') {
      emit(
        QuizExerciseShow(
          quiz: quiz,
          quizExercise: currentProblem,
          remainingDuration: Duration(seconds: remainingDuration),
          selectedAnswer: selectedAnswer,
          shortAnswer: shortAnswer,
          modalErrorMessage: currentProblem.type == 'MULTIPLE_CHOICE'
              ? 'Pilih salah satu jawaban'
              : 'Isi jawaban anda',
        ),
      );
      return;
    }
    try {
      var verdict = 'INCORRECT';

      if (currentProblem.type == 'MULTIPLE_CHOICE' &&
          currentProblem.answer.correctAnswer.contains(selectedAnswer)) {
        verdict = 'CORRECT';
      }

      if (currentProblem.type == 'SHORT_ANSWER' &&
          currentProblem.answer.correctAnswer
              .contains(shortAnswer.trim().toLowerCase())) {
        verdict = 'CORRECT';
      }

      attempt.answers?.add(
        QuizExerciseAnswer(
          answer: currentProblem.type == 'SHORT_ANSWER'
              ? shortAnswer
              : selectedAnswer,
          correctAnswer: currentProblem.answer.correctAnswer,
          taskChallengeGroup: currentProblem.challengeGroup,
          taskId: currentProblem.id,
          verdict: verdict,
        ),
      );

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
        selectedAnswer = '';
        shortAnswer = '';
        emit(
          QuizExerciseShow(
            quiz: quiz,
            quizExercise: currentProblem,
            remainingDuration: Duration(seconds: remainingDuration),
            selectedAnswer: selectedAnswer,
            shortAnswer: shortAnswer,
          ),
        );
      } else {
        attempt.score = (attempt.totalCorrect /
                (attempt.totalCorrect +
                    attempt.totalIncorrect +
                    attempt.totalBlank) *
                100)
            .toInt();
        attempt.endAt = DateTime.now();
        attempt.uploadedAt = DateTime.now();
        await quizExerciseRepository.insertQuizExerciseAttempt(
          quizParticipantId,
          attempt,
        );
        emit(QuizExerciseFinished(attempt));
      }
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }
}
