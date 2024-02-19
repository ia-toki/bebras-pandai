// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class TaskListPage extends StatefulWidget {
  final String? challengeGroup;
  const TaskListPage({super.key, this.challengeGroup});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    context.read<TaskListCubit>().initialize(group: widget.challengeGroup);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.bebrasPandaiText,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    widget.challengeGroup!,
                    textAlign: TextAlign.left,
                    style: FontTheme.blackTextBold()
                  ),
                  const SizedBox(
                    height: 14,
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
    var statusText = '';
    // Mengambil teks status berdasarkan nilai task.status
    if (task.status != null) {
      for (final item in dropdownItems) {
        if (item['value'] == task.status) {
          statusText = item['text'] ?? '';
          break;
        }
      }
    }

    return GestureDetector(
      onTap: () {
        String cleanedTaskId;
        if (task.id.startsWith('penegak_')) {
          cleanedTaskId = task.id.replaceFirst('penegak_', ''); 
        } else if (task.id.startsWith('sikecil_')) {
          cleanedTaskId = task.id.replaceFirst('sikecil_', '');
        } else if (task.id.startsWith('penggalang_')) {
          cleanedTaskId = task.id.replaceFirst('penggalang_', '');
        } else if (task.id.startsWith('siaga_')) {
          cleanedTaskId = task.id.replaceFirst('siaga_', '');
        } else {
          cleanedTaskId = task.id;
        }

        context.push(
          Uri(
            path: '/task_detail',
            queryParameters: {
              'task_id': cleanedTaskId,
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
                    Text(statusText),
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
