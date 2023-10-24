part of '_pages.dart';

class MaterialMenu extends StatefulWidget {
  const MaterialMenu({super.key});

  @override
  State<MaterialMenu> createState() => _MaterialMenuState();
}

class _MaterialMenuState extends State<MaterialMenu> {
  final Stream<QuerySnapshot> materialsStream =
      FirebaseFirestore.instance.collection('learning_material').snapshots();

  String? selectedValue = null;

  int filterIndex = 0;

  Widget CustomRadioButton(String text, int index) {
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
          color: (filterIndex == index) ? Colors.black54 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: (filterIndex == index) ? Colors.white : Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: (filterIndex == index)
                  ? Offset(0, 0)
                  : Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: (filterIndex == index) ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      avoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          CustomRadioButton(
                              "siKecil", bebrasGroupList[0].index),
                          CustomRadioButton("Siaga", bebrasGroupList[1].index),
                          CustomRadioButton(
                              "Penggalang", bebrasGroupList[2].index),
                          CustomRadioButton(
                              "Penegak", bebrasGroupList[3].index),
                        ]),
                  ),
                  // Container(
                  //   height: 70,
                  //   width: 296, // double.infinity,
                  //   decoration: BoxDecoration(border: Border.all()),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           CustomRadioButton(
                  //               "siKecil", bebrasGroupList[0].index),
                  //           CustomRadioButton(
                  //               "Siaga", bebrasGroupList[1].index),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           CustomRadioButton(
                  //               "Penggalang", bebrasGroupList[2].index),
                  //           CustomRadioButton(
                  //               "Penegak", bebrasGroupList[3].index),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      child: const Text('Latihan yang pernah diikuti')),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: materialsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return Container(
                          height: 360,
                          decoration: BoxDecoration(border: Border.all()),
                          child: ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> materialDoc =
                                  document.data()! as Map<String, dynamic>;
                              if (materialDoc['challenge_group'] ==
                                  bebrasGroupList[filterIndex]
                                      .bebrasChallengeKey) {
                                return InkWell(
                                  onTap: () {
                                    context.push(Uri(
                                        path: '/material/${document.id}',
                                        queryParameters: {
                                          'id': document.id,
                                          'title': materialDoc['title'],
                                          'description':
                                              materialDoc['description'],
                                          'pdfUrl': materialDoc['gsReference'],
                                        }).toString());
                                  },
                                  child: Container(
                                    height: 80,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 140,
                                            child: Text(
                                              materialDoc['title'].toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Container(
                                            width: 60,
                                            child: Text(
                                              'Terakhir dilihat: 15/09',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
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
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
