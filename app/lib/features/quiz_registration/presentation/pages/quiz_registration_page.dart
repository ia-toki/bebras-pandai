// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

part of '_pages.dart';

class QuizRegistrationPage extends StatefulWidget {
  const QuizRegistrationPage({super.key});

  @override
  State<QuizRegistrationPage> createState() => _QuizRegistrationPageState();
}

class _QuizRegistrationPageState extends State<QuizRegistrationPage> {
  final nama = 'dummy';
  String selectedWeek = '';

  @override
  void initState() {
    super.initState();
    context.read<QuizRegistrationCubit>().fetchRunningWeeklyQuiz();
  }

  void selectWeek(String week) {
    setState(() {
      selectedWeek = week;
    });
  }

  Widget quizCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(border: Border.all()),
      child: const Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quiz A',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Nilai: 100',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              'dikerjakan: 2023-09-09 09:09',
              style: TextStyle(fontSize: 12),
            )
          ],
        )
      ]),
    );
  }

  Future<void> showModal() async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            if (selectedWeek != '') {
              return Container(
                constraints: const BoxConstraints(minHeight: 30),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () => setState(() => selectedWeek = ''),
                        child: const Row(
                          children: [
                            Icon(Icons.chevron_left),
                            Text('Pilih Minggu')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Daftar Latihan Bebras ${selectedWeek == 'next_weekly_quiz' ? 'Minggu Depan' : 'Minggu Ini'}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: Button(
                          onTap: () => context
                              .read<QuizRegistrationCubit>()
                              .registerParticipant('sikecil', selectedWeek),
                          customButtonColor: Colors.blue.shade400,
                          customTextColor: Colors.white,
                          text: 'siKecil',
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: Button(
                          onTap: () => context
                              .read<QuizRegistrationCubit>()
                              .registerParticipant('siaga', selectedWeek),
                          customButtonColor: Colors.green.shade400,
                          customTextColor: Colors.white,
                          text: 'Siaga',
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: Button(
                          onTap: () => context
                              .read<QuizRegistrationCubit>()
                              .registerParticipant('penggalang', selectedWeek),
                          customButtonColor: Colors.red.shade400,
                          customTextColor: Colors.white,
                          text: 'Penggalang',
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: Button(
                          onTap: () => context
                              .read<QuizRegistrationCubit>()
                              .registerParticipant('penegak', selectedWeek),
                          customButtonColor: Colors.orange.shade400,
                          customTextColor: Colors.white,
                          text: 'Penegak',
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
            return Container(
              height: 260,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Daftar Latihan Bebras',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      child: Button(
                        onTap: () =>
                            setState(() => selectedWeek = 'next_weekly_quiz'),
                        customButtonColor: Colors.green.shade400,
                        customTextColor: Colors.white,
                        text: 'Latihan Minggu Depan',
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      child: Button(
                        onTap: () => setState(
                            () => selectedWeek = 'running_weekly_quiz'),
                        customButtonColor: Colors.brown.shade400,
                        customTextColor: Colors.white,
                        text: 'Latihan Minggu Ini',
                      ))
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() => null);
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 300,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(border: Border.all()),
                    child: ListView(children: [
                      const Text(
                        'Silahkan klik Tombol `Daftar Latihan Bebras` dibawah untuk memulai',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      quizCard(),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    buttonType: ButtonType.tertiary,
                    onTap: () async {
                      await showModal();
                    },
                    text: 'Daftar Latihan Bebras',
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
