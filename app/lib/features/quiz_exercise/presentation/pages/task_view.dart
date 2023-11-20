// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/bases/enum/button_type.dart';
import '../../../../core/bases/widgets/atoms/button.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/font_theme.dart';
import '../model/quiz_exercise.dart';

class TaskView extends StatelessWidget {
  final Duration? remainingDuration;
  final QuizExercise task;
  final BuildContext context;
  final Function onTap;
  const TaskView({
    required this.task,
    required this.context,
    required this.onTap,
    super.key,
    this.remainingDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Html(
              // ignore: prefer_adjacent_string_concatenation
              data: '<h3>Deskripsi</h3>${task.description.content}' +
                  '<h3>Pertanyaan</h3>${task.question.content}',
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        SizedBox(
          width: 150,
          child: Button(
            text: 'JAWAB',
            buttonType: ButtonType.primary,
            onTap: onTap,
          ),
        )
      ],
    );
  }
}
