// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    context.read<TaskListCubit>().initialize();
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
                  BlocBuilder<TaskListCubit, TaskListState>(
                    builder: (context, state) {
                      if (state is TaskListSuccess) {
                        return Column(
                          children: [
                            ...state.taskList.map(buildTaskItem),
                          ],
                        );
                      }
                      if (state is TaskListFailed) {
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

  Widget buildTaskItem(QuizExerciseBase task) {
    return GestureDetector(
      onTap: () {
        context.push(
          Uri(
            path: '/task_detail',
            queryParameters: {
              'task_id': task.id,
            },
          ).toString(),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(task.id),
                    Text(task.challengeGroup),
                  ],
                ),
                const SizedBox(height: 8),
                Text(task.title),
              ]),
            )),
      ),
    );
  }
}
