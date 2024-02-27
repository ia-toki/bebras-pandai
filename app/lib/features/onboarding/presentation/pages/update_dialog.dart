part of '_pages.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text('Versi Baru Tersedia'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Sebuah versi baru dari aplikasi tersedia.'),
              Text(
                'Silakan perbarui ke versi terbaru untuk '
                'menikmati fitur dan perbaikan baru.'
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text('Update Sekarang'),
              onPressed: () async {
                // Navigator.of(context).pop();
                final url = Uri.parse(
                  'https://play.google.com/store/apps/details?id=com.toki.bebras_pandai&hl=en-US&ah=i6XiDj6PnW-iPzIlbXBXM-jTYjA',
                );
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
          )
        ],
      )
    );
  }
}
