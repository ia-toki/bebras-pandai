part of '_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final nama = 'dummy';

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Halo! $nama'),
            Button(
              onTap: () async {
                await GoogleSignIn().signOut();
                context.go('/onboarding');
              },
              text: 'Log out',
            )
          ],
        ),
      ),
    );
  }
}
