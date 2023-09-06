part of '_pages.dart';

class UnderConstructionPage extends StatefulWidget {
  const UnderConstructionPage({super.key});

  @override
  State<UnderConstructionPage> createState() => _UnderConstructionPageState();
}

class _UnderConstructionPageState extends State<UnderConstructionPage> {
  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Image.asset(
              Assets.bebrasPandaiText,
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              'Maaf fitur ini sedang dalam perbaikan',
              style: FontTheme.blackTextBold(),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              Assets.logo,
            ),
            SizedBox(
              width: 200,
              child: Button(
                text: 'Kembali',
                buttonType: ButtonType.primary,
                onTap: () {
                  context.pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
