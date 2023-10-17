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
        child: Column(
          children: [
            // Row with Name, Subtitle, and Profile Picture
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                      Text('Subtitle', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.orange,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile_image.jpg'),
                      radius: 30,
                    ),
                  ),
                ],
              ),
            ),

            // Banner Photo with Rounded Radius
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage('/assets/bebras-banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200.0,
            ),

            // Horizontal Sliding with Big Icon Buttons
            Container(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {},
                    iconSize: 48.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                    iconSize: 48.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {},
                    iconSize: 48.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                    iconSize: 48.0,
                  ),
                ],
              ),
            ),

            // Popular Title Aligned Left
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Popular',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                    ),
                ),
              ),
            ),

            // Vertical List of Cards with Join Button
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return Card(
                  // Your card content and styling here
                  child: Column(
                    children: [
                      // Course details
                      Text(courses[index].title),
                      Text(courses[index].description),
                      // Join button
                      ElevatedButton(
                        onPressed: () {
                          // Handle join button click
                        },
                        child: Text('Join'),
                      ),
                    ],
                  ),
                );
              },
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
          ],
        ),
        // Stack(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(32),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Image.asset(
        //             Assets.bebrasPandaiText,
        //           ),
        //           const SizedBox(
        //             height: 100,
        //           ),
        //           RichText(
        //             text: TextSpan(
        //               text: 'Selamat Datang\n',
        //               style: FontTheme.blackTitle(),
        //               children: <TextSpan>[
        //                 TextSpan(
        //                   text:
        //                       // ignore: lines_longer_than_80_chars
        //                       '${FirebaseService.auth().currentUser?.displayName},',
        //                   style: FontTheme.blackTitleBold(),
        //                   // recognizer: TapGestureRecognizer()
        //                   //   ..onTap = () => context.go('/signup'),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 30,
        //           ),
        //           Button(
        //             buttonType: ButtonType.primary,
        //             onTap: () async {
        //               await context.push('/construction');
        //             },
        //             text: 'Lihat Materi',
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           Button(
        //             buttonType: ButtonType.primary,
        //             onTap: () async {
        //               await context.push('/construction');
        //             },
        //             text: 'Cetak Materi',
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           Button(
        //             buttonType: ButtonType.primary,
        //             onTap: () async {
        //               await context.push('/construction');
        //             },
        //             text: 'Ikut Quiz',
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           Button(
        //             buttonType: ButtonType.primary,
        //             onTap: () async {
        //               await GoogleSignIn().signOut();
        //               context.go('/onboarding');
        //             },
        //             text: 'Log out',
        //           ),
        //           const SizedBox(
        //             height: 60,
        //           ),
        //           InkWell(
        //             onTap: () async {
        //               final url = Uri.parse(
        //                 'https://bebras.or.id/v3/bebras-indonesia-challenge-2022/',
        //               );
        //               if (!await launchUrl(url)) {
        //                 throw Exception('Could not launch $url');
        //               }
        //             },
        //             child: Center(
        //               child: Text(
        //                 'Tentang Bebras Challange',
        //                 textAlign: TextAlign.center,
        //                 style: FontTheme.blackTextBold(),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
