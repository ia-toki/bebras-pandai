// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.isUpdateProfile});

  final String? isUpdateProfile;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final UserRegisterBloc _userRegisterBloc;
  String? selectedValue;

  @override
  void initState() {
    _userRegisterBloc = get<UserRegisterBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => get<UserRegisterBloc>()
        ..add(
          const InitialValueEvent(),
        ),
      child: BlocListener<UserRegisterBloc, RegisterFormState>(
        listener: (context, state) {
          if (state is UserRegisterSuccessState) {
            if (widget.isUpdateProfile == 'true') {
              // refresh page
              Navigator.pop(context);
              Navigator.push(
                context,
                // ignore: inference_failure_on_instance_creation
                MaterialPageRoute(
                  builder: (context) =>
                      const RegisterPage(isUpdateProfile: 'true'),
                ),
              );

              context.read<HomeCubit>().fetchUser();

              // add notification
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pembaruan data profil berhasil'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else {
              context.go('/main');
            }
          }
        },
        child: BlocBuilder<UserRegisterBloc, RegisterFormState>(
          builder: (context, state) {
            return BebrasScaffold(
              avoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 20,
                  right: 16,
                ),
                child: Form(
                  key: state.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Icon(
                                Icons.arrow_back
                              ),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                await context.push(
                                  Uri(
                                    path: '/register',
                                    queryParameters: {
                                      'isUpdateProfile': 'true',
                                    },
                                  ).toString(),
                                );
                              },
                              child: Container(
                                child: Center(
                                  child: const Text(
                                    'Edit Profil',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 50,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: const AssetImage(
                              'assets/images/beaver.png',
                            ),
                          ),
                        ]
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      CustomTextFieldV2(
                        'Email',
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
                      Text(
                        'Nama',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      CustomTextFieldV2(
                        'Nama',
                        (value) {
                          BlocProvider.of<UserRegisterBloc>(context)
                              .add(NameEvent(name: BlocFormItem(value: value)));
                        },
                        (val) {
                          return state.name.error;
                        },
                        state.name.value,
                      ),
                      // Text(
                      //   'Tempat Lahir',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      // CustomTextFieldV2(
                      //   'Tempat Lahir',
                      //   (value) {
                      //     BlocProvider.of<UserRegisterBloc>(context)
                      //         .add(NameEvent(name: BlocFormItem(value: value)));
                      //   },
                      //   (val) {
                      //     return state.name.error;
                      //   },
                      //   state.name.value,
                      // ),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      CustomDatePickerV2(
                        'Date',
                        (value) {
                          BlocProvider.of<UserRegisterBloc>(context).add(
                            BirthDateEvent(
                              birthDate: BlocFormItem(
                                value: value,
                              ),
                            ),
                          );
                        },
                        (val) {
                          return state.birthDate.error;
                        },
                        state.birthDate.value,
                      ),
                      Text(
                        'Asal Sekolah',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      CustomTextFieldV2(
                        'Asal Sekolah',
                        (value) {
                          BlocProvider.of<UserRegisterBloc>(context).add(
                            SchoolEvent(
                              school: BlocFormItem(
                                value: value,
                              ),
                            ),
                          );
                        },
                        (val) {
                          return state.school.error;
                        },
                        state.school.value,
                      ),
                      Text(
                        'Provinsi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        )
                      ),
                      const SizedBox(height: 3),
                      ProvinceDropdownV2(
                        // 'Provinsi',
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
                      Text(
                        'Biro Bebras',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      BiroBebrasDropdownV2(
                        'Bebras Biro',
                        (value) {
                          BlocProvider.of<UserRegisterBloc>(context).add(
                            BebrasBiroEvent(
                              bebrasBiro: BlocFormItem(
                                value: value,
                              ),
                            ),
                          );
                        },
                        (val) {
                          return state.bebrasBiro.error;
                        },
                        state.bebrasBiro.value.isNotEmpty
                            ? state.bebrasBiro.value
                            : 'Bebras Biro',
                      ),
                      const SizedBox(height: 5),
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
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(size.width, 45),
                              backgroundColor: Colors.lightBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
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
                                  ? 'Simpan'
                                  : 'Daftar',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
