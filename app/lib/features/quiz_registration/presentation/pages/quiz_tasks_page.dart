// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

part of '_pages.dart';

class QuizTasksPage extends StatefulWidget {
  final String? id;

  const QuizTasksPage({
    super.key,
    this.id,
  });

  @override
  State<QuizTasksPage> createState() => _QuizTasksPageState();
}

class _QuizTasksPageState extends State<QuizTasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuizRegistrationCubit>().fetchRunningQuizTasks('penegak');
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
                    height: 40,
                  ),
                  const Text('Latihan yang pernah diikuti'),
                  BlocConsumer<QuizRegistrationCubit, QuizRegistrationState>(
                    listener: (context, state) {
                      // if (state is QuizRegistrationSuccess) {
                      //   context
                      //       .read<QuizRegistrationCubit>()
                      //       .fetchParticipantWeeklyQuiz();
                      // }
                    },
                    builder: (context, state) {
                      if (state is QuizRegistrationLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 300,
                        width: double.infinity,
                        child: BlocConsumer<QuizRegistrationCubit,
                            QuizRegistrationState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            if (state is GetRunningQuizTasksSuccess) {
                              return ListView(children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(state.tasks)
                              ]);
                            }

                            if (state is GetParticipantWeeklyQuizFailed) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.only(bottom: 12, top: 12),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Silahkan klik Tombol `Daftar Latihan Bebras` dibawah untuk memulai',
                                  ),
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      );
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
}
