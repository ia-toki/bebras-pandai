part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> imgList = [
  'https://pandai.bebras.or.id/img/carousel5.ad104915.png',
  'https://pandai.bebras.or.id/img/banner2023.95952847.jpeg',
  'https://pandai.bebras.or.id/img/bebrasBanner.96a43a30.jpg',
  'https://pandai.bebras.or.id/img/grow-with-google-bebras-id.8d80a623.jpg',
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
              height: 250,
              color: const Color(0xFF1BB8E1),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 16),
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
                          .map(
                            (item) => Container(
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 150,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                    ),
                  ],
                ),
              ),
              const MaterialMenu(),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/quiz_registration');
        },
        child: const FaIcon(FontAwesomeIcons.graduationCap),
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
