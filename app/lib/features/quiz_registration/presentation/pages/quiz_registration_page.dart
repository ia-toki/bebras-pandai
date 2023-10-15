// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

part of '_pages.dart';

class QuizRegistrationPage extends StatefulWidget {
  const QuizRegistrationPage({super.key});

  @override
  State<QuizRegistrationPage> createState() => _QuizRegistrationPageState();
}

class _QuizRegistrationPageState extends State<QuizRegistrationPage> {
  final nama = 'dummy';

  @override
  Widget build(BuildContext context) {
    Future<void> showModal() async {
      return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return BlocConsumer<QuizRegistrationCubit, QuizRegistrationState>(
            listener: (context, state) {
              // TODO(someone): implement listener
            },
            builder: (context, state) {
              if (state is QuizRegistrationWeekSelected &&
                  state.selectedWeek != '') {
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
                          onTap: () => context
                              .read<QuizRegistrationCubit>()
                              .selectWeek(''),
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
                          'Daftar Latihan Bebras ${state.selectedWeek == 'next_week' ? 'Minggu Depan' : 'Minggu Ini'}',
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
                                .selectWeek('next_week'),
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
                                .selectWeek('this_week'),
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
                                .selectWeek('this_week'),
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
                                .selectWeek('this_week'),
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
                        style: TextStyle(
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
                              .selectWeek('next_week'),
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
                          onTap: () => context
                              .read<QuizRegistrationCubit>()
                              .selectWeek('this_week'),
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
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Silahkan klik Tombol `Daftar Latihan Bebras` dibawah untuk memulai',
                          )
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
