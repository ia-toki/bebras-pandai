part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

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
      body: Stack(
        children: [
          ClipPath(
            clipper: ClipPathClass(),
            child: Container(
              height: 250.0,
              color: Color(0xFF1BB8E1),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                      if (state is HomeSuccess) {
                        return RichText(
                          text: TextSpan(
                            text: 'Selamat Datang\n',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: toBeginningOfSentenceCase(
                                  '${state.user.name}!',
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    CarouselSlider(
                      items: imgList
                          .map((item) => Container(
                                margin: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(item, fit: BoxFit.cover, width: 300.0,),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 150,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // enlargeCenterPage: true,
                        // enlargeFactor: 0.3,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              const MaterialMenu(),
              //         Button(
              //           onTap: () async {
              //             final url = Uri.parse(
              //               'https://bebras.or.id/v3/bebras-indonesia-challenge-2023/',
              //             );
              //             if (!await launchUrl(url)) {
              //               throw Exception('Could not launch $url');
              //             }
              //           },
              //           customButtonColor: Colors.blue,
              //           customTextColor: Colors.white,
              //           text: 'ℹ️  Tentang Tantangan Bebras  ℹ️',
              //         ),
              //         const SizedBox(
              //           height: 25,
              //         ),
              //         Button(
              //           buttonType: ButtonType.primary,
              //           onTap: () async {
              //             await context.push('/material');
              //           },
              //           text: 'Lihat / Cetak Materi',
              //         ),
              //         const SizedBox(
              //           height: 25,
              //         ),
              //         Button(
              //           buttonType: ButtonType.primary,
              //           onTap: () async {
              //             await context.push('/quiz_registration');
              //           },
              //           text: 'Ikut Latihan Mingguan',
              //         ),
              //         const SizedBox(
              //           height: 25,
              //         ),
              //         Button(
              //           onTap: () async {
              //             await context.push('/setting');
              //           },
              //           customButtonColor: Colors.grey,
              //           customTextColor: Colors.white,
              //           text: 'Pengaturan',
              //         ),
              //         SizedBox(
              //           height: 120,
              //         ),
              //         InkWell(
              //           onTap: () async {
              //             final url = Uri.parse(
              //               'https://tlx.toki.id/',
              //             );
              //             if (!await launchUrl(url)) {
              //               throw Exception('Could not launch $url');
              //             }
              //           },
              //           child: Center(
              //             child: Text(
              //               'From Ikatan Alumni TOKI with ❤️',
              //               textAlign: TextAlign.center,
              //               style: FontTheme.greyNormal14(),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const FaIcon(FontAwesomeIcons.graduationCap),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
