// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class QuizResultPage extends StatefulWidget {
  final String? quizParticipantId;

  const QuizResultPage({super.key, this.quizParticipantId});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  @override
  void initState() {
    context.read<QuizResultCubit>().initialize(widget.quizParticipantId);
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
                    height: 40,
                  ),
                  BlocBuilder<QuizResultCubit, QuizResultState>(
                    builder: (context, state) {
                      if (state is QuizResultAvailable) {
                        return SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                'LATIHAN SELESAI',
                                style: FontTheme.blackTitleBold(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                Assets.logo,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    border: Border.all(), color: Colors.grey),
                                child: Column(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context).style,
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text: 'Total Nilai: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '${state.attempt.score}',
                                              style: const TextStyle(
                                                color: Colors.white, // White color for correct values
                                              ),
                                            ),
                                          ]
                                        )
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'benar: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${state.attempt.totalCorrect}, ',
                                            style: const TextStyle(
                                              color: Colors.white, // White color for correct values
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'salah: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${state.attempt.totalIncorrect + state.attempt.totalBlank}',
                                            style: const TextStyle(
                                              color: Colors.white, // White color for incorrect or blank values
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // const Text('MANTAP!!!')
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 750,
                              ),
                              const Center(
                                child: Text(
                                  'Sampai jumpa di Latihan Bebras selanjutnya. Selamat berlatih!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center, // Center the text horizontally
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      if (state is QuizResultNotAvailable) {
                        return const Text('Result not available');
                      }
                      if (state is QuizResultFailed) {
                        return Text(state.error);
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
