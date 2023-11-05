part of '_pages.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final nama = 'dummy';

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
                    height: 90,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      await context.push(Uri(
                      path: '/register',
                        queryParameters: {
                          'isUpdateProfile': 'true',
                        },
                      ).toString(),);
                    },
                    text: 'Edit Profil',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    onTap: () async {
                      final url = Uri.parse(
                        'https://docs.google.com/forms/d/1mUpZXTLvNU93C_bD-HeUTSTBVK1tRDE69t117dkE7ks/edit',
                      );
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    customButtonColor: Colors.grey,
                    customTextColor: Colors.white,
                    text: 'Hapus Akun',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Button(
                    buttonType: ButtonType.primary,
                    onTap: () async {
                      final url = Uri.parse(
                        'https://docs.google.com/document/d/1aj1cWrPak3f9On8Bj3KJO68p4MDtZPpWZCBquJZ9Nx0/edit',
                      );
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    text: 'Kebijakan Privasi',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    onTap: () async {
                      final url = Uri.parse(
                        'https://tip.fintix.id/iatoki',
                      );
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    customButtonColor: Colors.amber,
                    customTextColor: Colors.white,
                    text: 'Bantu Donasi 💌',
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Button(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      await GoogleSignIn().signOut();
                      context.go('/onboarding');
                    },
                    customButtonColor: Colors.red.shade900,
                    customTextColor: Colors.white,
                    text: 'Keluar',
                  ),
                  const SizedBox(
                    height: 40,
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
