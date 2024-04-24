// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bases/enum/button_type.dart';
import '../../../../../core/bases/widgets/atoms/button.dart';
import '../../../../../core/bases/widgets/atoms/html_cached_image.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/theme/base_colors.dart';
import '../../bloc/quiz_exercise_cubit.dart';
import '../../model/quiz_exercise.dart';
import '../../model/quiz_exercise_attempt.dart';

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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: BaseColors.brightBlue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${remainingDuration!.inMinutes.toString().padLeft(2, '0')} : ${remainingDuration!.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: BaseColors.brightBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  )
                )),
            if (remainingDuration != null)
              const SizedBox(
                height: 10,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      '${Assets.flagDir}${task.country}.png',
                      width: 20,
                      height: 10,
                    ),
                    Text(
                      task.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      task.source,
                      style: const TextStyle(fontSize: 7),
                    ),
                    Text(
                      task.id,
                      style: const TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 280,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF2FBFE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: HtmlWithCachedImages(
                  data: task.description.content
                      .replaceAll(Assets.sourceImg, Assets.urlImg),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Button(
              innerHorizontalPadding: 4,
              innerVerticalPadding: 8,
              fontSize: 13,
              text: 'Jawab',
              customButtonColor: BaseColors.brightBlue,
              customTextColor: Colors.white,
              borderRadius: 4,
              onTap: onTaskTap,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      if (showPreviousButton)
                        Button(
                          innerHorizontalPadding: 4,
                          innerVerticalPadding: 8,
                          fontSize: 13,
                          text: 'Sebelumnya',
                          customBorderColor: BaseColors.brightBlue,
                          customButtonColor: Colors.white,
                          customTextColor: BaseColors.brightBlue,
                          borderRadius: 4,
                          onTap: () {
                            context.read<QuizExerciseCubit>().toPreviousQuestion();
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: Column(
                    children: [
                      if (showNextButton && attempt.totalBlank != 0)
                        Button(
                          innerHorizontalPadding: 4,
                          innerVerticalPadding: 8,
                          fontSize: 13,
                          text: 'Selanjutnya',
                          customButtonColor: BaseColors.brightBlue,
                          customTextColor: Colors.white,
                          borderRadius: 4,
                          onTap: () {
                            context.read<QuizExerciseCubit>().toNextQuestion();
                          },
                        ),
                      if (attempt.totalBlank == 1)
                        Button(
                          innerHorizontalPadding: 4,
                          innerVerticalPadding: 8,
                          fontSize: 13,
                          text: 'Selesai',
                          customButtonColor: BaseColors.grey,
                          customTextColor: Colors.white,
                          borderRadius: 4,
                          isDisabled: true,
                          onTap: () {
                            context.read<QuizExerciseCubit>().finishExercise();
                          },
                        ),
                      if (attempt.totalBlank == 0)
                        Button(
                          innerHorizontalPadding: 4,
                          innerVerticalPadding: 8,
                          fontSize: 13,
                          text: 'Selesai',
                          customButtonColor: BaseColors.brightBlue,
                          customTextColor: Colors.white,
                          borderRadius: 4,
                          onTap: () {
                            context.read<QuizExerciseCubit>().finishExercise();
                          },
                        ),
                    ],
                  ), 
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(
            //         width: 50,
            //         child: Column(
            //           children: [
            //             if (showPreviousButton)
            //               Button(
            //                 innerHorizontalPadding: 4,
            //                 innerVerticalPadding: 8,
            //                 text: '<',
            //                 buttonType: ButtonType.primary,
            //                 onTap: () {
            //                   context
            //                       .read<QuizExerciseCubit>()
            //                       .toPreviousQuestion();
            //                 },
            //               ),
            //           ],
            //         )),
            //     Column(
            //       children: [
            //         SizedBox(
            //           width: 150,
            //           child: Button(
            //             innerHorizontalPadding: 4,
            //             innerVerticalPadding: 8,
            //             text: 'JAWAB',
            //             buttonType: ButtonType.primary,
            //             onTap: onTaskTap,
            //           ),
            //         ),
            //         if (attempt.totalBlank == 0)
            //           const SizedBox(
            //             height: 12,
            //           ),
            //         if (attempt.totalBlank == 0)
            //           SizedBox(
            //             width: 150,
            //             child: Button(
            //               innerHorizontalPadding: 4,
            //               innerVerticalPadding: 8,
            //               text: 'FINISH',
            //               buttonType: ButtonType.tertiary,
            //               onTap: () {
            //                 context.read<QuizExerciseCubit>().finishExercise();
            //               },
            //             ),
            //           ),
            //       ],
            //     ),
            //     SizedBox(
            //         width: 50,
            //         child: Column(
            //           children: [
            //             if (showNextButton)
            //               Button(
            //                 innerHorizontalPadding: 4,
            //                 innerVerticalPadding: 8,
            //                 text: '>',
            //                 buttonType: ButtonType.primary,
            //                 onTap: () {
            //                   context
            //                       .read<QuizExerciseCubit>()
            //                       .toNextQuestion();
            //                 },
            //               ),
            //           ],
            //         )),
            //   ],
            // ),
          ],
        ));
  }
}
