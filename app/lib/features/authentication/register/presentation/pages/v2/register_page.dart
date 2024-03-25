// ignore_for_file: lines_longer_than_80_chars

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
                      const RegisterPageV2(isUpdateProfile: 'true'),
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
                  top: 30,
                  right: 16,
                ),
                child: Form(
                  key: state.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        Assets.bebrasPandaiText,
                        height: 40,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Data Diri',
                          style: FontTheme.blackSubtitleBold(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
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
                      CustomTextField(
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
                      // CustomDatePicker(
                      //   'Tanggal Lahir',
                      //   (value) {
                      //     BlocProvider.of<UserRegisterBloc>(context).add(
                      //       BirthDateEvent(
                      //         birthDate: BlocFormItem(
                      //           value: value,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   (val) {
                      //     return state.birthDate.error;
                      //   },
                      //   state.birthDate.value,
                      // ),
                      CustomTextField(
                        'Sekolah',
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
                      ProvinceDropdown(
                        'Provinsi',
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
                      // BiroBebrasDropdown(
                      //   'Bebras Biro',
                      //   (value) {
                      //     BlocProvider.of<UserRegisterBloc>(context).add(
                      //       BebrasBiroEvent(
                      //         bebrasBiro: BlocFormItem(
                      //           value: value,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   (val) {
                      //     return state.bebrasBiro.error;
                      //   },
                      //   state.bebrasBiro.value.isNotEmpty
                      //       ? state.bebrasBiro.value
                      //       : 'Bebras Biro',
                      // ),
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
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(size.width, 45),
                              backgroundColor: Colors.black,
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
