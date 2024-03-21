class QuizExerciseAnswer {
  String answer;
  List<String> correctAnswer;
  String taskChallengeGroup;
  String taskId;
  String? verdict;

  QuizExerciseAnswer({
    required this.taskId,
    required this.answer,
    required this.correctAnswer,
    required this.taskChallengeGroup,
    this.verdict,
  });

  Map<String, Object?> toJson() {
    return {
      'answer': answer,
      'correct_answer': correctAnswer,
      'task_challenge_group': taskChallengeGroup,
      'task_id': taskId,
      'verdict': verdict,
    };
  }
}
