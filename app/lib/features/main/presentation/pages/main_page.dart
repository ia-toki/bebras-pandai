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
  final nama = 'dummy';
  final List<Course> courses = [
    Course('SiKecil', 'abdcdafadf'),
    Course('Siaga', 'abdcdafadf'),
    Course('Penggalang', 'abdcdafadf'),
    Course('Penegak', 'abdcdafadf'),
  ];

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

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
                  RichText(
                    text: TextSpan(
                      text: 'Selamat Datang\n',
                      style: FontTheme.blackTitle(),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              // ignore: lines_longer_than_80_chars
                              '${FirebaseService.auth().currentUser?.displayName},',
                          style: FontTheme.blackTitleBold(),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () => context.go('/signup'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/construction');
                    },
                    text: 'Lihat Materi',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/construction');
                    },
                    text: 'Cetak Materi',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push('/quiz_registration');
                    },
                    text: 'Ikut Quiz',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      await GoogleSignIn().signOut();
                      context.go('/onboarding');
                    },
                    text: 'Log out',
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse(
                        'https://bebras.or.id/v3/bebras-indonesia-challenge-2022/',
                      );
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Center(
                      child: Text(
                        'Tentang Bebras Challange',
                        textAlign: TextAlign.center,
                        style: FontTheme.blackTextBold(),
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
