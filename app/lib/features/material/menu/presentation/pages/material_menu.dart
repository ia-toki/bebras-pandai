part of '_pages.dart';

class MaterialMenu extends StatefulWidget {
  const MaterialMenu({super.key});

  @override
  State<MaterialMenu> createState() => _MaterialMenuState();
}

class _MaterialMenuState extends State<MaterialMenu> {
  final Stream<QuerySnapshot> materialsStream =
      FirebaseFirestore.instance.collection('learning_material').snapshots();

  String? selectedValue;

  int filterIndex = 0;

  Widget customRadioButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          filterIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 130,
        decoration: BoxDecoration(
          border: Border.all(),
          color: (filterIndex == index) ? Colors.black87 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: (filterIndex == index) ? Colors.white : Colors.black,
              blurRadius: 2,
              offset: (filterIndex == index)
                  // ignore: use_named_constants
                  ? const Offset(0, 0)
                  : const Offset(2, 2), // shadow direction: bottom right
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: (filterIndex == index) ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      avoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Image.asset(
                    Assets.bebrasPandaiText,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 40,
                    width: 296, // double.infinity,
                    decoration: BoxDecoration(border: Border.all()),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        customRadioButton(
                          'siKecil',
                          bebrasGroupList[0].index,
                        ),
                        customRadioButton('Siaga', bebrasGroupList[1].index),
                        customRadioButton(
                          'Penggalang',
                          bebrasGroupList[2].index,
                        ),
                        customRadioButton(
                          'Penegak',
                          bebrasGroupList[3].index,
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 70,
                  //   width: 296, // double.infinity,
                  //   decoration: BoxDecoration(border: Border.all()),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           customRadioButton(
                  //               "siKecil", bebrasGroupList[0].index),
                  //           customRadioButton(
                  //               "Siaga", bebrasGroupList[1].index),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           customRadioButton(
                  //               "Penggalang", bebrasGroupList[2].index),
                  //           customRadioButton(
                  //               "Penegak", bebrasGroupList[3].index),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                        return const Text('Loading');
                      }

                      return Container(
                        height: 360,
                        decoration: BoxDecoration(border: Border.all()),
                        child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            final materialDoc =
                                document.data()! as Map<String, dynamic>;
                            if (materialDoc['challenge_group'] ==
                                bebrasGroupList[filterIndex]
                                    .bebrasChallengeKey) {
                              return InkWell(
                                onTap: () {
                                  context.push(
                                    Uri(
                                      path: '/material/${document.id}',
                                      queryParameters: {
                                        'id': document.id,
                                        'title': materialDoc['title'],
                                        'description':
                                            materialDoc['description'],
                                        'pdfUrl': materialDoc['url'],
                                      },
                                    ).toString(),
                                  );
                                },
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 140,
                                          child: Text(
                                            materialDoc['title'].toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 60,
                                          child: Text(
                                            'Terakhir dilihat: 15/09',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
