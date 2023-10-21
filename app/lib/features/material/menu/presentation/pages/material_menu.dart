part of '_pages.dart';

class MaterialMenu extends StatefulWidget {
  const MaterialMenu({super.key});

  @override
  State<MaterialMenu> createState() => _MaterialMenuState();
}

class _MaterialMenuState extends State<MaterialMenu> {
  late final MaterialDocumentRepository _materialDocumentRepository;
  late final MaterialMenuBloc _materialMenuBloc;

  String? selectedValue = null;

  @override
  void initState() {
    _materialMenuBloc = get<MaterialMenuBloc>();
    _materialMenuBloc.add();

    super.initState();
  }
  int value = 0;

  Widget CustomRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // borderSide: BorderSide(color: (value == index) ? Colors.green  : Colors.black),
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MaterialMenuBloc(_materialDocumentRepository)..add(FetchMaterialDocumentEvent()),
        child: BebrasScaffold(
          // avoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.bebrasPandaiText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('Latihan yang pernah diikuti'),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<MaterialMenuBloc, MaterialMenuState>(
                        builder: (BuildContext context, state) {
                          if(state is AllMaterialFetchSuccess){
                            return Container();
                          } else {
                          return Container(
                            height: MediaQuery.of(context).size.height - 320,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(border: Border.all()),
                            child: ListView(
                              // padding: const EdgeInsets.all(8),
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    print('object');
                                    context.go('/material/9090');
                                  },
                                  child: Container(
                                    height: 80,
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(border: Border.all()),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Quiz A',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Skor: 90/100',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quiz A',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Skor: 90/100',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quiz A',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Skor: 90/100',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quiz A',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Skor: 90/100',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quiz A',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Skor: 90/100',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quiz A',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Skor: 90/100',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          }
                        },
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     CustomRadioButton("Single", 1),
                      //     CustomRadioButton("Married", 2),
                      //     CustomRadioButton("Other", 3)
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 34,
                                  width: 147,
                                  // padding: const EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Text(
                                    'siKecil',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 34,
                                  width: 147,
                                  // padding: const EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Text(
                                    'Siaga',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 34,
                                  width: 147,
                                  // padding: const EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Text(
                                    'Penegak',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 34,
                                  width: 147,
                                  // padding: const EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  child: Text(
                                    'Penggalang',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
