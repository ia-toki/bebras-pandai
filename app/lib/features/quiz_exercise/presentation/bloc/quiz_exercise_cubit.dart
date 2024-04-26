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
  int currentProblemIndex = 0;
  late List<String> problemIdList;
  late List<QuizExercise> problemList;
  late List<QuizExerciseAnswer> answerList;
  late QuizExerciseAttempt attempt;
  String? quizParticipantId;

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

      // reset index every time this method is called
      currentProblemIndex = 0;

      // Fetch all quiz data
      problemList = await quizExerciseRepository.getListQuizExercise(
          taskIds: problemIdList);
      problemList = problemList
          .where((quizExercise) =>
              quizExercise.type == 'MULTIPLE_CHOICE' ||
              quizExercise.type == 'MULTIPLE_CHOICE_IMAGE' ||
              quizExercise.type == 'SHORT_ANSWER')
          .toList();

      problemIdList = problemList
          .map((quizExercise) => quizExercise.id) // Extracting ids
          .toList();

      // TODO(someone): fix the check logic later
      // if (weeklyQuizParticipant.attempts.isEmpty) {
      answerList = problemList
          .map((e) => QuizExerciseAnswer(
              taskId: e.id,
              correctAnswer: e.answer.correctAnswer,
              answer: '',
              taskChallengeGroup: e.challengeGroup))
          .toList();
      attempt = QuizExerciseAttempt(
        startAt: DateTime.now(),
        totalBlank: problemIdList.length,
        totalCorrect: 0,
        totalIncorrect: 0,
      );

      final duration = quiz.duration_minute[participation.challenge_group];
      if (duration == null) {
        throw Exception('Duration for selected Challenge Group not found');
      }
      remainingDuration = (duration * 60.0).toInt();
      timer = Timer.periodic(const Duration(seconds: 1), timerCallback);
      emit(
        QuizExerciseShow(
          quiz: quiz,
          quizExercise: problemList[currentProblemIndex],
          remainingDuration: Duration(seconds: remainingDuration),
          answer: answerList[currentProblemIndex],
          attempt: attempt,
          currentProblemIndex: currentProblemIndex,
          totalProblem: problemIdList.length,
        ),
      );
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }

  void selectAnswer(String answerId) {
    answerList[currentProblemIndex].answer = answerId;
    emit(
      QuizExerciseShow(
        quiz: quiz,
        quizExercise: problemList[currentProblemIndex],
        remainingDuration: Duration(seconds: remainingDuration),
        answer: answerList[currentProblemIndex],
        attempt: attempt,
        currentProblemIndex: currentProblemIndex,
        totalProblem: problemIdList.length,
      ),
    );
  }

  void fillAnswer(String answer) {
    answerList[currentProblemIndex].answer = answer;
    emit(
      QuizExerciseShow(
        quiz: quiz,
        quizExercise: problemList[currentProblemIndex],
        remainingDuration: Duration(seconds: remainingDuration),
        attempt: attempt,
        answer: answerList[currentProblemIndex],
        currentProblemIndex: currentProblemIndex,
        totalProblem: problemIdList.length,
      ),
    );
  }

  Future<bool> updateStatus(String taskId, String? status) async {
    try {
      quizExerciseRepository = QuizExerciseRepository();
      await quizExerciseRepository.updateQuizExercise(taskId, status);
      return true;
    } catch (e) {
      // Handle errors, log, etc.
      print('Error updating status: $e');
      return false; // Operation failed
    }
  }

  Future<void> finishExerciseTimeUp() async {
    await postQuizExerciseAttempt();
    emit(QuizExerciseFinished(
      quizParticipantId!,
      Duration(seconds: remainingDuration),
    ));
  }

  Future<void> submitAnswer() async {
    final currentProblem = problemList[currentProblemIndex];
    final answer = answerList[currentProblemIndex].answer;
    if (answer == '') {
      emit(
        QuizExerciseShow(
          quiz: quiz,
          quizExercise: currentProblem,
          remainingDuration: Duration(seconds: remainingDuration),
          attempt: attempt,
          answer: answerList[currentProblemIndex],
          modalErrorMessage: currentProblem.type == 'SHORT_ANSWER'
              ? 'Isi jawaban anda'
              : 'Pilih salah satu jawaban',
          currentProblemIndex: currentProblemIndex,
          totalProblem: problemIdList.length,
        ),
      );
      return;
    }

    var verdict = 'INCORRECT';
    if ((currentProblem.type == 'MULTIPLE_CHOICE' ||
            currentProblem.type == 'MULTIPLE_CHOICE_IMAGE') &&
        currentProblem.answer.correctAnswer.contains(answer)) {
      verdict = 'CORRECT';
    }
    if (currentProblem.type == 'SHORT_ANSWER' &&
        currentProblem.answer.correctAnswer
            .map((answer) => answer.toLowerCase())
            .contains(answer.trim().toLowerCase())) {
      verdict = 'CORRECT';
    }
    answerList[currentProblemIndex].verdict = verdict;

    attempt.totalBlank = answerList.where((e) => e.verdict == null).length;
    attempt.totalCorrect = answerList
        .where((e) => e.verdict != null && e.verdict == 'CORRECT')
        .length;
    attempt.totalIncorrect = answerList
        .where((e) => e.verdict != null && e.verdict == 'INCORRECT')
        .length;

    toNextQuestion();
  }

  Future<void> finishExercise() async {
    try {
      await postQuizExerciseAttempt();
      emit(QuizExerciseFinished(
        quizParticipantId!,
        Duration(seconds: remainingDuration),
      ));
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }

  void toNextQuestion() {
    if (currentProblemIndex == problemIdList.length - 1) return;
    currentProblemIndex++;
    emit(
      QuizExerciseShow(
        quiz: quiz,
        quizExercise: problemList[currentProblemIndex],
        remainingDuration: Duration(seconds: remainingDuration),
        attempt: attempt,
        answer: answerList[currentProblemIndex],
        currentProblemIndex: currentProblemIndex,
        totalProblem: problemIdList.length,
      ),
    );
  }

  void toPreviousQuestion() {
    if (currentProblemIndex == 0) return;
    currentProblemIndex--;
    emit(
      QuizExerciseShow(
        quiz: quiz,
        quizExercise: problemList[currentProblemIndex],
        remainingDuration: Duration(seconds: remainingDuration),
        attempt: attempt,
        answer: answerList[currentProblemIndex],
        currentProblemIndex: currentProblemIndex,
        totalProblem: problemIdList.length,
      ),
    );
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

  void timerCallback(Timer timer) {
    if (state is! QuizExerciseShow) {
      timer.cancel();
    } else if (remainingDuration > 0) {
      remainingDuration--;
      emit(
        QuizExerciseShow(
          quiz: quiz,
          quizExercise: problemList[currentProblemIndex],
          remainingDuration: Duration(seconds: remainingDuration),
          attempt: attempt,
          answer: answerList[currentProblemIndex],
          currentProblemIndex: currentProblemIndex,
          totalProblem: problemIdList.length,
        ),
      );
    } else {
      timer.cancel();
      finishExerciseTimeUp();
    }
  }

  Future<void> pause() async {
    timer?.cancel();
    emit(QuizExercisePaused());
  }

  Future<void> resume() async {
    timer = Timer.periodic(const Duration(seconds: 1), timerCallback);
    emit(
      QuizExerciseShow(
        quiz: quiz,
        quizExercise: problemList[currentProblemIndex],
        remainingDuration: Duration(seconds: remainingDuration),
        attempt: attempt,
        answer: answerList[currentProblemIndex],
        currentProblemIndex: currentProblemIndex,
        totalProblem: problemIdList.length,
      ),
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
