class QuizExerciseAnswer {
  String answer;
  List<String> correctAnswer;
  String taskChallengeGroup;
  String taskId;
  String verdict;

  QuizExerciseAnswer({
    required this.answer,
    required this.correctAnswer,
    required this.taskChallengeGroup,
    required this.taskId,
    required this.verdict,
  });
}
