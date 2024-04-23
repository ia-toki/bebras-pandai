// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class QuizStartPage extends StatefulWidget {
  final String? quizParticipantId;

  const QuizStartPage({super.key, this.quizParticipantId});

  @override
  State<QuizStartPage> createState() => _QuizStartPageState();
}

int lineNumber = 1;

class _QuizStartPageState extends State<QuizStartPage> {
  @override
  void initState() {
    context.read<QuizStartCubit>().initialize(widget.quizParticipantId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1BB8E1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();

                            context
                                .read<QuizStartCubit>()
                                .setAgreement(value: false);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Latihan Bebras',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42),
                    topRight: Radius.circular(42),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(child: BlocBuilder<QuizStartCubit, QuizStartState>(
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
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSuccessState(QuizStartSuccess state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 340,
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Jumlah soal: ${state.quiz.problems[state.participation.challenge_group]?.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          'Alokasi waktu: ${state.quiz.duration_minute[state.participation.challenge_group]} menit',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          'Sisa coba lagi: ${state.participation.quiz_max_attempts - state.participation.attempts.length}/${state.participation.quiz_max_attempts}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          'Peraturan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTnC(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: state.agreement,
                            onChanged: (state.participation.attempts.length <
                                    state.participation.quiz_max_attempts)
                                ? (value) {
                                    if (value != null) {
                                      context
                                          .read<QuizStartCubit>()
                                          .setAgreement(value: value);
                                    }
                                  }
                                : null,
                            activeColor: const Color(0xFF1BB8E1),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                if (state.participation.attempts.length <
                                    state.participation.quiz_max_attempts) {
                                  final newValue = !state.agreement;
                                  context
                                      .read<QuizStartCubit>()
                                      .setAgreement(value: newValue);
                                }
                              },
                              child: const Text(
                                'Saya telah membaca peraturan & akan mengerjakan dengan jujur',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Button(
                isDisabled: !state.agreement ||
                    state.participation.attempts.length >=
                        state.participation.quiz_max_attempts,
                onTap: () async {
                  Navigator.pop(context);
                  context.read<QuizStartCubit>().setAgreement(value: false);
                  await context.push(
                    Uri(
                      path: '/quiz_exercise',
                      queryParameters: {
                        'quiz_participant_id': state.participation.id,
                      },
                    ).toString(),
                  );
                },
                customButtonColor: const Color(0xFF1BB8E1),
                customTextColor: Colors.white,
                text: 'Mulai',
                innerVerticalPadding: 12,
                borderRadius: 4,
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildTnC() {
  final tnc = <String>[
    'Saya telah membaca atau meminta orang tua / wali saya membaca informasi dan prosedur untuk mengikuti Tantangan Bebras 2023 ini, sehingga saya telah memahami dan menyetujui partisipasi saya dalam tantangan ini',
    'Saya mengikuti Tantangan Bebras 2023 ini atas kemauan sendiri dan tanpa paksaan dari pihak manapun.',
    'Saya bersedia mengikuti/mengerjakan soal-soal Tantangan Bebras 2023 dengan jujur dan penuh tanggungjawab.',
    'Tetap menjaga Kesehatan dan mengikuti protokol kesehatan Covid-19 selama mengikuti tantangan.',
    'Tidak akan mendokumentasikan dan atau menyebarkan soal-soal Tantangan Bebras 2023 dalam bentuk apapun, serta untuk keperluan dan dengan cara apapun.',
    'Latihan harus diselesaikan tanpa keluar dari halaman latihan. Jika latihan sedang berlangsung dan Anda keluar, latihan akan dinyatakan selesai dan skor dihitung seadanya.'
  ];

  return ListView.builder(
    shrinkWrap: true,
    itemCount: tnc.length,
    itemBuilder: (context, index) {
      final text = tnc[index];
      final lineNumber = index + 1; //
      final isWrapped = text.length > 50;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$lineNumber. ',
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                ),
                softWrap: true,
                textAlign: isWrapped ? TextAlign.start : TextAlign.justify,
              ),
            ),
          ],
        ),
      );
    },
  );
}
