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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1BB8E1),
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Latihan Bebras Mingguan',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  Assets.topSectionBg,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 70,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                        children: [
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
                    BlocBuilder<QuizStartCubit, QuizStartState>(
                      builder: (context, state) {
                        if (state is QuizStartSuccess) {
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: state.agreement,
                                        onChanged: (value) {
                                          if (value != null) {
                                            context
                                                .read<QuizStartCubit>()
                                                .setAgreement(value: value);
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
                                          'quiz_participant_id':
                                              state.participation.id,
                                        },
                                      ).toString(),
                                    );
                                  },
                                  text: 'Mulai',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                state.participation.attempts.isNotEmpty
                                    ? Button(
                                        buttonType: ButtonType.primary,
                                        isDisabled: state
                                            .participation.attempts.isEmpty,
                                        onTap: () async {
                                          await context.push(
                                            Uri(
                                              path: '/quiz_result',
                                              queryParameters: {
                                                'quiz_participant_id':
                                                    state.participation.id,
                                              },
                                            ).toString(),
                                          );
                                        },
                                        text: 'Lihat Nilai',
                                      )
                                    : Container(),
                              ],
                            ),
                          );
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                          'Jumlah soal: ${state.quiz.problems[state.participation.challenge_group]?.length}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                          'Alokasi waktu: ${state.quiz.duration_minute[state.participation.challenge_group]} menit',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                          'Sisa coba lagi: ${state.participation.quiz_max_attempts - state.participation.attempts.length}/${state.participation.quiz_max_attempts}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                        child: Text('Peraturan',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 23,
                                child: Text('1.'),
                              ),
                              Flexible(
                                child: Text(
                                    'Setiap peserta diharapkan mencoba untuk mengakses situr tantangan di hhtps://tantanganbebras.ipb.ac.id untuk mencoba akun dan berlatih kecil sebelum jadwal tantangan pada hari 4-6 November 2023.'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 23,
                                child: Text('2.'),
                              ),
                              Flexible(
                                child: Text(
                                    'Coba Akun/Latihan di situs tantangan.'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
