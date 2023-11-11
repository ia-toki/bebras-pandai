// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/quiz_participation.dart';
import '../../../../models/weekly_quiz.dart';
import '../../../../services/quiz_service.dart';
import '../model/quiz_exercise.dart';
import '../model/quiz_exercise_answer.dart';
import '../model/quiz_exercise_attempt.dart';
import '../repositories/quiz_exercise.dart';

part 'quiz_exercise_state.dart';

class QuizExerciseCubit extends Cubit<QuizExerciseState> {
  QuizExerciseCubit() : super(QuizExerciseInitialState());

  late WeeklyQuiz quiz;
  late WeeklyQuizParticipation participation;
  late QuizExercise currentProblem;
  int currentProblemIndex = 0;
  late List<String> problemIdList;
  late QuizExerciseAttempt attempt;
  String? quizParticipantId;

  String selectedAnswer = '';
  String shortAnswer = '';
  late int remainingDuration;
  Timer? timer;

  late QuizService quizService;
  late QuizExerciseRepository quizExerciseRepository;

  FutureOr<void> initialize({String? quizParticipantId}) async {
    try {
      quizService = QuizService();
      quizExerciseRepository = QuizExerciseRepository();

      emit(QuizExerciseLoading());
      if (quizParticipantId == null) {
        throw Exception('Quiz Participant Id null');
      }
      this.quizParticipantId = quizParticipantId;

      final participation = await quizService.getWeeklyQuizParticipant(
        quizParticipantId: quizParticipantId,
      );

      quiz = await quizService.getWeeklyQuizById(participation.quiz_id);

      final list = quiz.problems[participation.challenge_group];
      if (list == null) {
        throw Exception(
            'Task set for `${participation.challenge_group}` is not found');
      }
      problemIdList = list;
      if (problemIdList.isEmpty) {
        throw Exception(
            'Task set for `${participation.challenge_group}` is empty');
      }

      // Shuffle Problem List
      problemIdList.shuffle();

      // TODO(someone): fix the check logic later
      // if (weeklyQuizParticipant.attempts.isEmpty) {
      attempt = QuizExerciseAttempt(
        startAt: DateTime.now(),
        totalBlank: problemIdList.length,
        totalCorrect: 0,
        totalIncorrect: 0,
        answers: [],
      );

      // reset index every time this method is called
      currentProblemIndex = 0;

      // Fetch all quiz data for it to be available when offline
      await quizExerciseRepository.getListQuizExercise(problemIdList);

      currentProblem =
          await quizExerciseRepository.getQuizExercise(problemIdList.first);

      final duration = quiz.duration_minute[participation.challenge_group];
      if (duration == null) {
        throw Exception('Duration for selected Challenge Group not found');
      }
      remainingDuration = (duration * 60.0).toInt();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
              shortAnswer: shortAnswer,
            ),
          );
        } else {
          timer.cancel();
          finishExerciseTimeUp();
        }
      });
      emit(
        QuizExerciseShow(
          quiz: quiz,
          quizExercise: currentProblem,
          remainingDuration: Duration(seconds: remainingDuration),
          selectedAnswer: selectedAnswer,
          shortAnswer: shortAnswer,
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
        shortAnswer: shortAnswer,
      ),
    );
  }

  Future<void> finishExerciseTimeUp() async {
    await postQuizExerciseAttempt();
    emit(QuizExerciseFinished(quizParticipantId!));
  }

  Future<void> submitAnswer() async {
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
              .map((answer) => answer.toLowerCase())
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
        await postQuizExerciseAttempt();
        emit(QuizExerciseFinished(quizParticipantId!));
      }
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }

  Future<void> postQuizExerciseAttempt() async {
    attempt.score = (attempt.totalCorrect /
            (attempt.totalCorrect +
                attempt.totalIncorrect +
                attempt.totalBlank) *
            100)
        .toInt();
    attempt.endAt = DateTime.now();
    attempt.uploadedAt = DateTime.now();
    await quizExerciseRepository.insertQuizExerciseAttempt(
        quizParticipantId!, attempt);
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
