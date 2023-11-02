part of '_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class Course {
  String title;
  String description;

  Course(this.title, this.description);
}

class _MainPageState extends State<MainPage> {
  final registeredUserSnapshot = FirebaseFirestore.instance
      .collection('registered_user')
      .doc(FirebaseService.auth().currentUser?.uid)
      .get();

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
                  FutureBuilder(
                    future: registeredUserSnapshot,
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      final useData = snapshot.data?.data();
                      return RichText(
                        text: TextSpan(
                          text: 'Selamat Datang\n',
                          style: FontTheme.blackTitle(),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                              toBeginningOfSentenceCase('${useData['name']}!'),
                              style: FontTheme.blackTitleBold(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
                    height: 20,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/material');
                    },
                    text: 'Lihat / Cetak Materi',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/final_score');
                    },
                    text: '(Dummy) Final Score Page',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/quiz_registration');
                    },
                    text: 'Ikut Latihan Mingguan',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    onTap: () async {
                      await context.push('/setting');
                    },
                    customButtonColor: Colors.grey,
                    customTextColor: Colors.white,
                    text: 'Pengaturan',
                  ),
                  const SizedBox(
                    height: 255,
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
                        'From Ikatan Alumni TOKI with 🩷',
                        textAlign: TextAlign.center,
                        style: FontTheme.greyNormal14(),
                      ),
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
