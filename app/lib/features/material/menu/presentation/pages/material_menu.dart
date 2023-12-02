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
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      constraints: const BoxConstraints(
        minWidth: 60,
        maxWidth: 140,
        minHeight: 20.0,
        maxHeight: 25.0,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom( //<-- SEE HERE
          side: BorderSide(width: 1, color: Color(0xFF1BB8E1),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        // buttonType: filterIndex == index ? ButtonType.secondary : null,
        child: Text(text, style: TextStyle(
          fontSize: 14.0,
            color: Colors.black,
        )
        ),
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
        height: 60,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
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
                  color: Colors.blue,
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
    return
      // BebrasScaffold(
      // avoidBottomInset: false,
      // body: Padding(
      //   padding: const EdgeInsets.only(top: 10),
      //   child:
        Stack(
          children: [
            Container(
              // padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  // Image.asset(
                  //   Assets.bebrasPandaiText,
                  // ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text('Daftar Materi'),
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
                      final boxHeight =
                          MediaQuery.of(context).size.height - 320;
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: boxHeight,
                          width: double.infinity,
                          child: ListView(
                            children: [
                              ...snapshot.data!.docs.map((d) {
                                final materialDoc =
                                    d.data()! as Map<String, dynamic>;
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
                                  ), // Set the desired offset
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
              ),
            ),
          ],
        );
    //   ),
    // );
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
