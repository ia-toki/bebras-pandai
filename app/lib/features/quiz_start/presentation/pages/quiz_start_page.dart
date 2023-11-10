part of '_pages.dart';

class QuizStartPage extends StatefulWidget {
  final String? quizParticipantId;

  QuizStartPage({super.key, this.quizParticipantId});

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
                      return Text('OK');
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
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Text(state.quiz.title),
                    Text(
                        'Jumlah soal: ${state.quiz.problems[state.participation.challenge_group]?.length}'),
                    Text(
                        'Alokasi waktu: ${state.quiz.duration_minute[state.participation.challenge_group]} menit'),
                    Text(
                        'Sisa coba lagi ${state.participation.attempts.length} / ${state.participation.quiz_max_attempts}'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Peraturan'),
                    Text('Pra Tantangan'),
                    Text('1. 12312312312'),
                    Text('2. qwerqwrqrwf'),
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
                    context.read<QuizStartCubit>().setAgreement(value);
                  }
                }),
            Flexible(
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
