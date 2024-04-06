// part of '_pages.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/bases/widgets/layout/bebras_scaffold.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      avoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 20,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Container(
                          child: Icon(
                        Icons.arrow_back,
                      )),
                    )),
                Flexible(
                    child: Center(
                  child: Text('Hapus Akun',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                )),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Container(
                  child: const Text(
                      'Kami sangat menyesal mendengar bahwa Anda mempertimbangkan untuk menghapus akun Anda di Bebras Pandai. '
                      'Sebelum Anda melangkah lebih jauh, kami ingin memastikan Anda memahami konsekuensi dari penghapusan akun. Mohon perhatikan informasi berikut:',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Column(children: [
              Container(
                  child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 30,
                      width: 30,
                      child: Center(
                        child: const Text(
                          '1',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        shape: BoxShape.circle,
                      )),
                  Flexible(
                      child: Text('Kehilangan Akses',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )))
                ],
              )),
              const SizedBox(
                height: 5,
              ),
              Column(children: [
                Container(
                    child: const Text(
                        'Menghapus akun berarti Anda akan kehilangan akses ke semua data, prestasi, dan konten yang terkait dengan akun Anda, '
                        'termasuk riwayat latihan yang pernah Anda kerjakan.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )))
              ]),
            ]),
            const SizedBox(
              height: 5,
            ),
            Column(children: [
              Container(
                  child: Row(children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 30,
                    width: 30,
                    child: Center(
                      child: const Text(
                        '2',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      shape: BoxShape.circle,
                    )),
                Flexible(
                    child: Text('Tidak Dapat Dipulihkan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )))
              ])),
              const SizedBox(
                height: 5,
              ),
              Column(children: [
                Container(
                    child: const Text(
                        'Penghapusan akun bersifat permanen dan tidak dapat dipulihkan. '
                        'Pastikan untuk mempertimbangkan keputusan ini secara hati-hati sebelum melanjutkan.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )))
              ])
            ]),
            const SizedBox(
              height: 5,
            ),
            Column(children: [
              Container(
                  child: Row(children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 30,
                    width: 30,
                    child: Center(
                      child: const Text(
                        '3',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      shape: BoxShape.circle,
                    )),
                Flexible(
                    child: Text('Pertanyaan dan Bantuan',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )))
              ])),
              const SizedBox(
                height: 5,
              ),
              Column(children: [
                Container(
                    child: const Text(
                        'Jika Anda memiliki pertanyaan atau memerlukan bantuan, tim dukungan kami siap membantu. '
                        'Hubungi kami di support@bebraspandai.com.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )))
              ])
            ]),
            const SizedBox(
              height: 5,
            ),
            Column(children: [
              Container(
                  child: Row(children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 30,
                    width: 30,
                    child: Center(
                      child: const Text(
                        '4',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      shape: BoxShape.circle,
                    )),
                Flexible(
                    child: Text('Peringatan Akhir',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )))
              ])),
              const SizedBox(
                height: 5,
              ),
              Column(children: [
                Container(
                    child: const Text(
                        'Sebelum menekan tombol "Hapus Akun," pastikan Anda telah mempertimbangkan keputusan ini dengan matang.'
                        'Kami berharap Anda mempertimbangkan untuk tetap menjadi tetap mengikuti perjalanan pendidikan bersama kami.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )))
              ])
            ]),
            const SizedBox(
              height: 30,
            ),
            Text(
                'Terima kasih atas partisipasi Anda di Bebras Pandai. Kami berharap Anda mempertimbangkan pilihan Anda dengan cermat sebelum mengambil langkah ini.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final url = Uri.parse(
                    'https://docs.google.com/forms/d/1mUpZXTLvNU93C_bD-HeUTSTBVK1tRDE69t117dkE7ks/edit',
                  );
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Text('Hapus Akun')),
          ],
        ),
      ),
    );
  }
}
