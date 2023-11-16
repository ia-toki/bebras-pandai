// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class TaskDetailPage extends StatefulWidget {
  final String? taskId;
  const TaskDetailPage({super.key, this.taskId});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  void initState() {
    context.read<TaskDetailCubit>().initialize(taskId: widget.taskId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Image.asset(
                    Assets.bebrasPandaiText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<TaskDetailCubit, TaskDetailState>(
                    builder: (context, state) {
                      if (state is TaskDetailSuccess) {
                        final taskDecription =
                            '<h3>Deskripsi</h3>${state.task.description.content}';
                        final taskQuestion =
                            '<h3>Pertanyaan</h3>${state.task.question.content}';

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  '${Assets.flagDir}${state.task.country}.png',
                                  width: 40,
                                  height: 20,
                                ),
                                Flexible(
                                  child: Text(
                                    state.task.title,
                                    textAlign: TextAlign.center,
                                    style: FontTheme.blackSubtitleBold(),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      state.task.id,
                                      style: const TextStyle(fontSize: 9),
                                    ),
                                    Text(
                                      state.task.source,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(border: Border.all()),
                              child: SingleChildScrollView(
                                child: Html(
                                  data: taskDecription + taskQuestion,
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
                                onTap: () {
                                  showAnswerOptions();
                                },
                              ),
                            )
                          ],
                        );
                      }
                      if (state is TaskDetailFailed) {
                        return Text(state.error);
                      }
                      return Text('');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAnswerOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<TaskDetailCubit, TaskDetailState>(
              buildWhen: (context, state) {
            return state is TaskDetailSuccess;
          }, builder: (context, state) {
            if (state is TaskDetailSuccess) {
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
                            child: Html(data: state.task.question.content),
                          ),
                        ),
                        ...state.task.question.options!.map((e) =>
                            RadioListTile(
                                title: Text(e.content),
                                value: e.id,
                                groupValue: false,
                                onChanged: (value) {})),
                      ],
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: Button(
                        buttonType: ButtonType.tertiary,
                        text: 'Ok',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox(
              width: 100,
              height: 100,
            );
          });
        });
  }
}
