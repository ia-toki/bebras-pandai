// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class QuizStartPage extends StatefulWidget {
  final String? quizParticipantId;

  const QuizStartPage({super.key, this.quizParticipantId});

  @override
  State<QuizStartPage> createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage> {
  @override
  void initState() {
    context.read<QuizStartCubit>().initialize(widget.quizParticipantId);
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
                  BlocBuilder<QuizStartCubit, QuizStartState>(
                    builder: (context, state) {
                      if (state is QuizStartSuccess) {
                        return buildSuccessState(state);
                      }
                      if (state is QuizStartFailed) {
                        return Text(state.error);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
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

  Widget buildSuccessState(QuizStartSuccess state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(state.quiz.title),
                    ),
                    Text(
                        'Jumlah soal: ${state.quiz.problems[state.participation.challenge_group]?.length}'),
                    Text(
                        'Alokasi waktu: ${state.quiz.duration_minute[state.participation.challenge_group]} menit'),
                    Text(
                        'Sisa coba lagi: ${state.participation.quiz_max_attempts - state.participation.attempts.length} dari ${state.participation.quiz_max_attempts} kesempatan'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Peraturan'),
                    const Text('Pra Tantangan'),
                    const Text('1. 12312312312'),
                    const Text('2. qwerqwrqrwf'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Checkbox(
                value: state.agreement,
                onChanged: (value) {
                  if (value != null) {
                    context.read<QuizStartCubit>().setAgreement(value: value);
                  }
                }),
            const Flexible(
                child: Text(
                    'Saya telah membaca peraturan & akan mengerjakan dengan jujur'))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Button(
          buttonType: ButtonType.tertiary,
          isDisabled: !state.agreement ||
              state.participation.attempts.length >=
                  state.participation.quiz_max_attempts,
          onTap: () async {
            Navigator.pop(context);
            await context.push(
              Uri(
                path: '/quiz_exercise',
                queryParameters: {
                  'quiz_participant_id': state.participation.id,
                },
              ).toString(),
            );
          },
          text: 'Mulai',
        ),
        const SizedBox(
          height: 10,
        ),
        Button(
          buttonType: ButtonType.primary,
          isDisabled: state.participation.attempts.isEmpty,
          onTap: () async {
            await context.push(
              Uri(
                path: '/quiz_result',
                queryParameters: {
                  'quiz_participant_id': state.participation.id,
                },
              ).toString(),
            );
          },
          text: 'Lihat Nilai',
        ),
      ],
    );
  }
}
