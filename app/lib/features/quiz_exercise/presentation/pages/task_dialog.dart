import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core/bases/enum/button_type.dart';
import '../../../../core/bases/widgets/atoms/button.dart';
import '../../../../core/theme/font_theme.dart';
import '../../../authentication/register/presentation/widgets/custom_text_field.dart';
import '../bloc/quiz_exercise_cubit.dart';
import '../model/quiz_exercise.dart';

class TaskDialog extends StatelessWidget {
  final String? shortAnswer;
  final String? selectedAnswer;
  final String? error;
  final bool preview;
  final QuizExercise task;
  const TaskDialog({
    required this.task,
    required this.preview,
    super.key,
    this.shortAnswer,
    this.selectedAnswer,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Pertanyaan',
                  style: FontTheme.blackTextBold(),
                ),
              ),
              SizedBox(
                width: 400,
                height: 200,
                child: SingleChildScrollView(
                  child: Html(data: task.question.content),
                ),
              ),
              if (!preview)
                ...task.question.options!.asMap().entries.map((e) {
                  final current = String.fromCharCode(65 + e.key);

                  return RadioListTile(
                      title: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Text(
                              current,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            task.type == 'MULTIPLE_CHOICE_IMAGE'
                                ? Image.network(
                                    e.value.content,
                                    width: 140,
                                  )
                                : Text(e.value.content),
                          ],
                        ),
                      ),
                      value: e.value.id,
                      groupValue: selectedAnswer,
                      onChanged: (value) {
                        context
                            .read<QuizExerciseCubit>()
                            .selectAnswer(e.value.id);
                      });
                }),
              if (!preview)
                task.type == 'SHORT_ANSWER'
                    ? Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomTextField('Jawaban anda', (value) {
                          context.read<QuizExerciseCubit>().fillAnswer(value);
                        }, (p0) => null, ''),
                      )
                    : Container(),
              if (!preview)
                if (error != null) Text(error!),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: 100,
            height: 50,
            child: Button(
              buttonType: ButtonType.secondary,
              text: 'Cancel',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            width: 100,
            height: 50,
            child: Button(
              buttonType: ButtonType.tertiary,
              text: 'OK',
              onTap: () {
                var error = '';
                if (task.type == 'SHORT_ANSWER') {
                  if (shortAnswer == '') {
                    error = 'Isi jawaban anda';
                  }
                } else {
                  if (selectedAnswer == '') {
                    error = 'Pilih salah satu jawaban';
                  }
                }

                if (error != '') {
                  final snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                    margin:
                        const EdgeInsets.only(bottom: 50, left: 10, right: 10),
                    content: Text(error),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  error = '';
                  return;
                }

                context.read<QuizExerciseCubit>().submitAnswer();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
