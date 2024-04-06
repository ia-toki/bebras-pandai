part of '_pages.dart';

class MaterialMenu extends StatefulWidget {
  const MaterialMenu({super.key});

  @override
  State<MaterialMenu> createState() => _MaterialMenuState();
}

class _MaterialMenuState extends State<MaterialMenu> {
  String basePath =
      '/storage/emulated/0/Android/data/com.toki.bebras_pandai/files/PDF_Download/';
  int filterIndex = 0;
  String? selectedValue;

  MaterialRepository materialRepository = MaterialRepository();
  late Stream<QuerySnapshot> materialsStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  Future<void> _initializeStream() async {
    try {
      materialsStream = materialRepository.getListMaterials();
    } catch (e) {
      print('Error initializing stream: $e');
    }
  }

  Widget materialTab(String text, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      constraints: const BoxConstraints(
        minWidth: 60,
        maxWidth: 140,
        minHeight: 20,
        maxHeight: 25,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor:
              filterIndex == index ? const Color(0xFF1BB8E1) : Colors.white,
          side: BorderSide(
            color: filterIndex == index ? const Color(0xFF1BB8E1) : Colors.grey,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(text,
            style: TextStyle(
              fontSize: 14,
              color:
                  filterIndex == index ? Colors.white : const Color(0xFF9E9E9E),
            )),
        onPressed: () {
          setState(() {
            filterIndex = index;
          });
        },
      ),
    );
  }

  Widget materialItem(
    String docId,
    String title,
    String url,
    // ignore: avoid_positional_boolean_parameters
    bool isPrintable,
  ) {
    return InkWell(
      onTap: () {
        context.push(
          Uri(
            path: '/material/$docId',
            queryParameters: {
              'id': docId,
              'title': title,
              'pdfUrl': url,
            },
          ).toString(),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          bottom: 12,
          left: 5,
          right: 5,
        ),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              24,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              Assets.icon,
              width: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(title),
            ),
            if (isPrintable)
              IconButton(
                onPressed: () {
                  _generatePdf(docId);
                },
                icon: const Icon(
                  Icons.print_rounded,
                  size: 28,
                  color: Color(0xFF1BB8E1),
                ),
                iconSize: 28,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            buildMaterialCategory(context),
            buildMaterialList(),
          ],
        ),
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

  Column buildMaterialCategory(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Kategori Materi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width - 10,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ...bebrasGroupList.map(
                (e) => materialTab(e.label, e.index),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildMaterialList() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Daftar Materi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: materialsStream,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var displayEmpty = true;
            final boxHeight = MediaQuery.of(context).size.height - 440;
            return SingleChildScrollView(
              child: SizedBox(
                height: boxHeight,
                width: double.infinity,
                child: ListView(
                  children: [
                    ...snapshot.data!.docs.map((d) {
                      final materialDoc = d.data()! as Map<String, dynamic>;
                      if (materialDoc['challenge_group'] ==
                          bebrasGroupList[filterIndex].key) {
                        displayEmpty = false;
                        return materialItem(
                          d.id,
                          materialDoc['title'] as String,
                          materialDoc['url'] as String,
                          File('$basePath${d.id}.pdf').existsSync(),
                        );
                      }
                      return Container();
                    }),
                    if (displayEmpty)
                      Transform.translate(
                        offset: const Offset(
                          0,
                          -10,
                        ),
                        child: Container(
                          height: boxHeight,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(
                            bottom: 12,
                            top: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Materi belum ada',
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // PDF print
  Future<void> _generatePdf(String id) async {
    try {
      final file = File('$basePath$id.pdf');
      final fileInByte = file.readAsBytesSync();
      await Printing.layoutPdf(onLayout: (_) => fileInByte);
    } catch (e) {
      // Do Nothing
    }
  }
}
