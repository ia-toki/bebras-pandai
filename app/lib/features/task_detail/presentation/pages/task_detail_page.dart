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
                        return TaskView(
                          task: state.task,
                          context: context,
                          onTap: () {
                            onTaskTap();
                          },
                        );
                      }
                      if (state is TaskDetailFailed) {
                        return Text(state.error);
                      }
                      return const Text('');
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

  void onTaskTap() {
    // ignore: inference_failure_on_function_invocation
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<TaskDetailCubit, TaskDetailState>(
              buildWhen: (context, state) {
            return state is TaskDetailSuccess;
          }, builder: (context, state) {
            if (state is TaskDetailSuccess) {
              return TaskDialog(
                task: state.task,
                preview: true,
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
