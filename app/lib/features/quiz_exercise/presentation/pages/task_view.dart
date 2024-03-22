// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bases/enum/button_type.dart';
import '../../../../core/bases/widgets/atoms/button.dart';
import '../../../../core/bases/widgets/atoms/html_cached_image.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/font_theme.dart';
import '../bloc/quiz_exercise_cubit.dart';
import '../model/quiz_exercise.dart';
import '../model/quiz_exercise_attempt.dart';

class TaskView extends StatelessWidget {
  final Duration? remainingDuration;
  final QuizExercise task;
  final QuizExerciseAttempt attempt;
  final BuildContext context;
  final Function onTaskTap;
  final bool showPreviousButton;
  final bool showNextButton;
  const TaskView({
    required this.task,
    required this.context,
    required this.onTaskTap,
    required this.attempt,
    super.key,
    this.showPreviousButton = false,
    this.showNextButton = false,
    this.remainingDuration,
  });

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Anda akan keluar dari latihan?'),
            content: const Text(
                'Latihan akan dianggap selesai dengan hasil seadanya'),
            actions: <Widget>[
              SizedBox(
                width: 100,
                height: 50,
                child: Button(
                  buttonType: ButtonType.secondary,
                  text: 'Cancel',
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ),
              SizedBox(
                  width: 100,
                  height: 50,
                  child: Button(
                      buttonType: ButtonType.tertiary,
                      text: 'Ya',
                      onTap: () {
                        context
                            .read<QuizExerciseCubit>()
                            .finishExerciseTimeUp();
                        Navigator.of(context).pop(true);
                      }))
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Display the popup when the back button is pressed
          final result = await _showExitConfirmationDialog(context);
          return result;
        },
        child: Column(
          children: [
            if (remainingDuration != null)
              Container(
                color: Colors.yellowAccent,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                    '${remainingDuration!.inMinutes.toString().padLeft(2, '0')} : ${remainingDuration!.inSeconds.remainder(60).toString().padLeft(2, '0')}'),
              ),
            if (remainingDuration != null)
              const SizedBox(
                height: 10,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  '${Assets.flagDir}${task.country}.png',
                  width: 40,
                  height: 20,
                ),
                Flexible(
                  child: Text(
                    task.title,
                    textAlign: TextAlign.center,
                    style: FontTheme.blackSubtitleBold(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      task.id,
                      style: const TextStyle(fontSize: 9),
                    ),
                    Text(
                      task.source,
                      style: const TextStyle(fontSize: 7),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 340,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(border: Border.all()),
              child: SingleChildScrollView(
                child: HtmlWithCachedImages(
                  // ignore: prefer_adjacent_string_concatenation
                  // data: '<h3>Deskripsi</h3>${task.description.content}' +
                  //     '<h3>Pertanyaan</h3>${task.question.content}',
                  data: task.description.content
                      .replaceAll(Assets.sourceImg, Assets.urlImg),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        if (showPreviousButton)
                          Button(
                            innerHorizontalPadding: 4,
                            innerVerticalPadding: 8,
                            text: '<',
                            buttonType: ButtonType.primary,
                            onTap: () {
                              context
                                  .read<QuizExerciseCubit>()
                                  .toPreviousQuestion();
                            },
                          ),
                      ],
                    )),
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Button(
                        innerHorizontalPadding: 4,
                        innerVerticalPadding: 8,
                        text: 'JAWAB',
                        buttonType: ButtonType.primary,
                        onTap: onTaskTap,
                      ),
                    ),
                    if (attempt.totalBlank == 0)
                      SizedBox(
                        height: 12,
                      ),
                    if (attempt.totalBlank == 0)
                      SizedBox(
                        width: 150,
                        child: Button(
                          innerHorizontalPadding: 4,
                          innerVerticalPadding: 8,
                          text: 'FINISH',
                          buttonType: ButtonType.tertiary,
                          onTap: () {
                            context.read<QuizExerciseCubit>().toNextQuestion();
                          },
                        ),
                      ),
                  ],
                ),
                SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        if (showNextButton)
                          Button(
                            innerHorizontalPadding: 4,
                            innerVerticalPadding: 8,
                            text: '>',
                            buttonType: ButtonType.primary,
                            onTap: () {
                              context
                                  .read<QuizExerciseCubit>()
                                  .toNextQuestion();
                            },
                          ),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
