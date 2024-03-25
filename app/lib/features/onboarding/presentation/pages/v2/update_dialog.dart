// part of '_pages.dart';

// class UpdateDialog extends StatelessWidget {
//   const UpdateDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: AlertDialog(
//         title: const Text('Versi Baru Tersedia'),
//         content: const SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(
//                 'Versi terbaru dari aplikasi sudah tersedia. '
//                 'Silahkan download aplikasi terbaru untuk menggunakan '
//                 'Bebras Pandai'
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Keluar Aplikasi'),
//             onPressed: () {
//               Navigator.of(context).pop();
//               SystemNavigator.pop();
//             },
//           ),
//           TextButton(
//             child: const Text('Update Sekarang'),
//             onPressed: () async {
//               // Navigator.of(context).pop();
//               final url = Uri.parse(
//                 'https://play.google.com/store/apps/details?id=com.toki.bebras_pandai&hl=en-US&ah=i6XiDj6PnW-iPzIlbXBXM-jTYjA',
//               );
//               if (!await launchUrl(url)) {
//                 throw Exception('Could not launch $url');
//               }
//             },
//           ),
//         ],
//       )
//     );
//   }
// }
