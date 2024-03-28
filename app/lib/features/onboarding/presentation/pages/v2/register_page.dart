part of '_pages.dart';

class RegisterPageV2 extends StatefulWidget {
  const RegisterPageV2({super.key, this.isUpdateProfile});

  final String? isUpdateProfile;

  @override
  State<RegisterPageV2> createState() => _RegisterPageV2State();
}

class _RegisterPageV2State extends State<RegisterPageV2> {
  late final UserRegisterBloc _userRegisterBloc;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1BB8E1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42.0),
                    topRight: Radius.circular(42.0),
                  ),
                ),
                child: BlocBuilder<UserRegisterBloc, RegisterFormState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ayo isi data diri kamu!',
                            style: FontTheme.blackSubtitleBold(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: CustomTextField(
                            (value) {
                                BlocProvider.of<UserRegisterBloc>(context).add(
                                EmailEvent(email: BlocFormItem(value: value)),
                                );
                            },
                            (val) {
                                return state.email.error;
                            },
                            state.email.value,
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nama',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: CustomTextField(
                            (value) {
                                BlocProvider.of<UserRegisterBloc>(context).add(
                                NameEvent(name: BlocFormItem(value: value)),
                                );
                            },
                            (val) {
                                return state.name.error;
                            },
                            state.email.value,
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sekolah',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: CustomTextField(
                            (value) {
                                BlocProvider.of<UserRegisterBloc>(context).add(
                                SchoolEvent(school: BlocFormItem(value: value)),
                                );
                            },
                            (val) {
                                return state.school.error;
                            },
                            state.email.value,
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Provinsi',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ProvinceDropdown(
                            (value) {
                              BlocProvider.of<UserRegisterBloc>(context).add(
                                ProvinceEvent(
                                  province: BlocFormItem(
                                    value: value,
                                  ),
                                ),
                              );
                            },
                            (val) {
                              return state.province.error;
                            },
                            state.province.value.isNotEmpty
                            ? state.province.value
                            : 'Provinsi',
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Button(
                                  borderRadius: 4,
                                  customTextColor: Colors.white,
                                  customButtonColor: const Color(0xFF1BB8E1),
                                  fontSize: 14,
                                  innerVerticalPadding: 10,
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                  },
                                  text: 'Daftar',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}