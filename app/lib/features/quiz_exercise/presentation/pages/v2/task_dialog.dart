import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/bases/widgets/atoms/button.dart';
import '../../../../../core/bases/widgets/atoms/html_cached_image.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/theme/base_colors.dart';
import '../../../../authentication/register/presentation/widgets/custom_text_field.dart';
import '../../bloc/quiz_exercise_cubit.dart';
import '../../model/quiz_exercise.dart';

class TaskDialog extends StatelessWidget {
  final String? answer;
  final String? error;
  final bool preview;
  final QuizExercise task;
  const TaskDialog({
    required this.task,
    required this.preview,
    super.key,
    this.answer,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 30),
      width: double.infinity,
      color: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            if (task.type == 'MULTIPLE_CHOICE')
              ...task.question.options.asMap().entries.map((e) {
                final current = String.fromCharCode(65 + e.key);

                return RadioListTile(
                  title: SizedBox(
                    child: Transform.translate(
                      offset: const Offset(-20, 0),
                      child: Row(
                        children: [
                          Text('$current. '),
                          task.type == 'MULTIPLE_CHOICE_IMAGE'
                              ? Image.network(
                                  e.value.content.replaceAll(
                                      Assets.sourceImg, Assets.urlImg),
                                  width: MediaQuery.of(context).size.width - 240,
                                )
                              : Flexible(
                                  child: HtmlWithCachedImages(data: e.value.content),
                                )
                        ],
                      ),
                    ),
                  ),
                  value: e.value.id,
                  groupValue: answer,
                  onChanged: (value) {
                    context.read<QuizExerciseCubit>().selectAnswer(e.value.id);
                  },
                );
              }),
            if (task.type == 'SHORT_ANSWER')
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: CustomTextField(
                  'Jawaban anda',
                  (value) {
                    context.read<QuizExerciseCubit>().fillAnswer(value);
                  },
                  (p0) => null,
                  answer,
                ),
              ),
            if (!preview) if (error != null) Text(error!),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: Expanded(
                child: Button(
                  innerHorizontalPadding: 4,
                  innerVerticalPadding: 8,
                  fontSize: 13,
                  text: 'Pilih Jawaban',
                  customButtonColor: BaseColors.brightBlue,
                  customTextColor: Colors.white,
                  borderRadius: 4,
                  onTap: () {
                    var error = '';
                    if (task.type == 'SHORT_ANSWER') {
                      if (answer == '') {
                        error = 'Isi jawaban anda';
                      }
                    } else {
                      if (answer == '') {
                        error = 'Pilih salah satu jawaban';
                      }
                    }

                    if (error != '') {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.only(
                            bottom: 50, left: 10, right: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
