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
    _userRegisterBloc = get<UserRegisterBloc>();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return BebrasScaffold(
    //   body: Container(
    //     height: double.infinity,
    //     child: Stack(
    //       children: [
    //         Container(
    //           height: 200,
    //           width: double.infinity,
    //           decoration: const BoxDecoration(
    //             color: Color(0xFF1BB8E1),
    //             borderRadius: BorderRadius.only(
    //               bottomLeft: Radius.circular(60),
    //               bottomRight: Radius.circular(60),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           top: 100,
    //           left: 0,
    //           right: 0,
    //           bottom: 0,
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(horizontal: 20),
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(42.0),
    //                 topRight: Radius.circular(42.0),
    //               ),
    //             ),
    //             child: BlocBuilder<UserRegisterBloc, RegisterFormState>(
    //               builder: (context, state) {
    //                 return Column(
    //                   children: [
    //                     const SizedBox(
    //                       height: 40,
    //                     ),
    //                     Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: Text(
    //                         'Ayo isi data diri kamu!',
    //                         style: FontTheme.blackSubtitleBold(),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 30,
    //                     ),
    //                     Container(
    //                       margin: EdgeInsets.only(bottom: 5),
    //                       child: Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           'Email',
    //                           style: const TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       child: CustomTextField(
    //                         (value) {
    //                             BlocProvider.of<UserRegisterBloc>(context).add(
    //                             EmailEvent(email: BlocFormItem(value: value)),
    //                             );
    //                         },
    //                         (val) {
    //                             return state.email.error;
    //                         },
    //                         state.email.value,
    //                         ),
    //                     ),
    //                     Container(
    //                       margin: EdgeInsets.only(bottom: 5),
    //                       child: Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           'Nama',
    //                           style: const TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       child: CustomTextField(
    //                         (value) {
    //                             BlocProvider.of<UserRegisterBloc>(context).add(
    //                             NameEvent(name: BlocFormItem(value: value)),
    //                             );
    //                         },
    //                         (val) {
    //                             return state.name.error;
    //                         },
    //                         state.email.value,
    //                         ),
    //                     ),
    //                     Container(
    //                       margin: EdgeInsets.only(bottom: 5),
    //                       child: Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           'Sekolah',
    //                           style: const TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       child: CustomTextField(
    //                         (value) {
    //                             BlocProvider.of<UserRegisterBloc>(context).add(
    //                             SchoolEvent(school: BlocFormItem(value: value)),
    //                             );
    //                         },
    //                         (val) {
    //                             return state.school.error;
    //                         },
    //                         state.email.value,
    //                         ),
    //                     ),
    //                     Container(
    //                       margin: EdgeInsets.only(bottom: 5),
    //                       child: Align(
    //                         alignment: Alignment.centerLeft,
    //                         child: Text(
    //                           'Provinsi',
    //                           style: const TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       margin: EdgeInsets.only(bottom: 10),
    //                       child: ProvinceDropdown(
    //                         (value) {
    //                           BlocProvider.of<UserRegisterBloc>(context).add(
    //                             ProvinceEvent(
    //                               province: BlocFormItem(
    //                                 value: value,
    //                               ),
    //                             ),
    //                           );
    //                         },
    //                         (val) {
    //                           return state.province.error;
    //                         },
    //                         state.province.value.isNotEmpty
    //                         ? state.province.value
    //                         : 'Provinsi',
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Align(
    //                         alignment: FractionalOffset.bottomCenter,
    //                         child: Column(
    //                           children: [
    //                             const SizedBox(
    //                               height: 10,
    //                             ),
    //                             Button(
    //                               borderRadius: 4,
    //                               customTextColor: Colors.white,
    //                               customButtonColor: const Color(0xFF1BB8E1),
    //                               fontSize: 14,
    //                               innerVerticalPadding: 10,
    //                               onTap: () async {
    //                                 Navigator.of(context).pop();
    //                               },
    //                               text: 'Daftar',
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => get<UserRegisterBloc>()
        ..add(
          const InitialValueEvent(),
        ),
      child: BlocListener<UserRegisterBloc, RegisterFormState>(
        listener: (context, state) {
          if (widget.isUpdateProfile == 'true') {
            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const RegisterPageV2(isUpdateProfile: 'true'),
              ),
            );

            context.read<HomeCubit>().fetchUser();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pembaruan data profil berhasil'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            context.go('/main');
          }
        },
        child: BlocBuilder<UserRegisterBloc, RegisterFormState>(
          builder: (context, state) {
            return BebrasScaffold(
              body: SizedBox(
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
                        decoration: const BoxDecoration(
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
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomTextField(
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
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Nama',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomTextField(
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
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Sekolah',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomTextField(
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
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Provinsi',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 10),
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
                                const SizedBox(height: 20),
                                BlocConsumer<UserRegisterBloc, RegisterFormState>(
                                  bloc: _userRegisterBloc,
                                  listener: (context, state) {
                                    if (state is UserRegisterSuccessState) {
                                      if (widget.isUpdateProfile == 'true') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'Profile data successfully updated',
                                            ),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        context.go('/main');
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    // return Button(
                                    //   borderRadius: 4,
                                    //   customTextColor: Colors.white,
                                    //   customButtonColor: const Color(0xFF1BB8E1),
                                    //   fontSize: 14,
                                    //   // innerVerticalPadding: 10,
                                    //   onTap: () async {
                                    //     Navigator.of(context).pop();
                                    //   },
                                    //   text: 'Daftar',
                                    // );
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(size.width, 45),
                                        backgroundColor: const Color(0xFF1BB8E1),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (state is! UserRegisterLoadingState) {
                                          if (widget.isUpdateProfile == 'true') {
                                            BlocProvider.of<UserRegisterBloc>(context)
                                                .add(const FormSubmitUpdateEvent());
                                          } else {
                                            BlocProvider.of<UserRegisterBloc>(context)
                                                .add(const FormSubmitEvent());
                                          }
                                        }
                                      },
                                      child: Text(
                                        widget.isUpdateProfile == 'true'
                                            ? 'Perbarui'
                                            : 'Daftar',
                                        style:
                                            const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  },
                                ),
                                // Expanded(
                                //   child: Align(
                                //     alignment: FractionalOffset.bottomCenter,
                                //     child: Column(
                                //       children: [
                                //         const SizedBox(
                                //           height: 10,
                                //         ),
                                //         Button(
                                //           borderRadius: 4,
                                //           customTextColor: Colors.white,
                                //           customButtonColor: const Color(0xFF1BB8E1),
                                //           fontSize: 14,
                                //           innerVerticalPadding: 10,
                                //           onTap: () async {
                                //             Navigator.of(context).pop();
                                //           },
                                //           text: 'Daftar',
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
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
          },
        ),
      ),
    );
  }
}