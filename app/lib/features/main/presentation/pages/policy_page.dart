part of '_pages.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
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
                  child: Text('Kebijakan Privasi',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  child: const Text(
                      'Selamat datang di Kebijakan Privasi Bebras Pandai! '
                      'Kami sangat menghargai kepercayaan dan privasi Anda '
                      'Sebagai pengguna Bebras Pandai, Anda memiliki hak untuk mengetahui bagaimana data Anda diambil, digunakan, dan dijaga.'
                      'Mohon luangkan waktu sejenak untuk membaca kebijakan privasi kami:',
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
                      child: Text('Informasi yang kami kumpulkan',
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
                        'Bebras Pandai mengumpulkan informasi yang diperlukan untuk pengaturan akun dan meningkatkan pengalaman pengguna. '
                        'Ini mungkin mencakup nama, alamat email, dan informasi profil tambahan yang Anda pilih untuk dibagikan.',
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
                    child: Text('Penggunaan Informasi',
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
                        'Informasi yang kami kumpulkan digunakan untuk menyajikan konten yang sesuai dengan minat Anda, memantau kinerja aplikasi, dan memastikan keamanan akun Anda. '
                        'Kami tidak pernah menyediakan informasi pribadi Anda kepada pihak ketiga tanpa izin Anda.',
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
                    child: Text('Keamanan Data',
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
                        'Keamanan data Anda adalah prioritas kami.'
                        'Kami menggunakan langkah-langkah keamanan yang ketat untuk melindungi informasi pribadi Anda dari akses yang tidak sah atau penggunaan yang tidak sah.',
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
                    child: Text('Perubahan Kebijakan Privasi',
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
                        'Kebijakan Privasi kami dapat diperbarui dari waktu ke waktu.'
                        'Pemberitahuan perubahan akan disajikan melalui aplikasi atau situs web kami. Pastikan untuk memeriksa kebijakan ini secara berkala.',
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
                        '5',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      shape: BoxShape.circle,
                    )),
                Flexible(
                    child: Text('Kontak Kami',
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
                        'Jika Anda memiliki pertanyaan atau kekhawatiran tentang kebijakan privasi kami, jangan ragu untuk menghubungi tim dukungan kami di support@bebraspandai.com.'
                        'Dengan menggunakan Bebras Pandai, Anda menyetujui Kebijakan Privasi kami. Terima kasih atas kepercayaan dan partisipasi Anda dalam Aplikasi Bebras Pandai!',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )))
              ])
            ]),
          ],
        ),
      ),
    );
  }
}
