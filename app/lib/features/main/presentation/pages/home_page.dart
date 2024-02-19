part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Course {
  String title;
  String description;

  Course(this.title, this.description);
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().fetchUser();
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
                  BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                    if (state is HomeSuccess) {
                      return RichText(
                        text: TextSpan(
                          text: 'Selamat Datang\n',
                          style: FontTheme.blackTitle(),
                          children: <TextSpan>[
                            TextSpan(
                                text: toBeginningOfSentenceCase(
                                  '${state.user.name}!',
                                ),
                                style: FontTheme.blackTitleBold()),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    onTap: () async {
                      final url = Uri.parse(
                        'https://bebras.or.id/v3/bebras-indonesia-challenge-2023/',
                      );
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    customButtonColor: Colors.blue,
                    customTextColor: Colors.white,
                    text: 'ℹ️  Tentang Tantangan Bebras  ℹ️',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/material');
                    },
                    text: 'Lihat / Cetak Materi',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/quiz_registration');
                    },
                    text: 'Ikut Latihan Mingguan',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Button(
                    onTap: () async {
                      await context.push('/setting');
                    },
                    customButtonColor: Colors.grey,
                    customTextColor: Colors.white,
                    text: 'Pengaturan',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 640,
                  ),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse(
                        'https://tlx.toki.id/',
                      );
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Center(
                      child: Text(
                        'From Ikatan Alumni TOKI with ❤️',
                        textAlign: TextAlign.center,
                        style: FontTheme.greyNormal14(),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                        'V 1.0.0',
                        textAlign: TextAlign.center,
                        style: FontTheme.greyNormal14(),
                      ),
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
