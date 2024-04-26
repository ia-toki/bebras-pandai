// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class QuizResultPage extends StatefulWidget {
  final String? quizParticipantId;
  final String? isTimeUp;

  const QuizResultPage({super.key, this.quizParticipantId, this.isTimeUp});

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
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<QuizResultCubit, QuizResultState>(
                    builder: (context, state) {
                      if (state is QuizResultAvailable) {
                        return SizedBox(
                          child: Column(
                            children: [
                              widget.isTimeUp == 'true' ?
                              Text(
                                'WAKTU HABIS',
                                style: FontTheme.blackSubtitleBold(),
                              ) : Text(
                                'LATIHAN SELESAI',
                                style: FontTheme.blackSubtitleBold(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              widget.isTimeUp == 'true' ?
                              Image.asset(height: 200, Assets.timeUp) :
                              Image.asset(
                                height: 250,
                                Assets.logo,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: const Color(0x0F1BB8E1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Nilai: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '${state.attempt.score}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0x4D1BB8E1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Soal Salah: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${state.attempt.totalIncorrect + state.attempt.totalBlank}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0x4D1BB8E1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Soal Benar: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${state.attempt.totalCorrect}',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Center(
                                child: Text(
                                  'Sampai jumpa di Latihan Bebras selanjutnya!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign
                                      .center, // Center the text horizontally
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
          child: Button(
            onTap: () => context.go('/task_list'),
            text: 'Selesai',
            // buttonType: ButtonType.tertiary,
            customButtonColor: Color(0xFF1BB8E1),
            customTextColor: Colors.white,
            innerVerticalPadding: 10,
            borderRadius: 8,
          ),
        ),
      ),
    );
  }
}
