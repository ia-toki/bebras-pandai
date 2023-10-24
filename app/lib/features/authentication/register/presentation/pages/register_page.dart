part of '_pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final UserRegisterBloc _userRegisterBloc;
  TextEditingController dateinput = TextEditingController();

  String? selectedValue = null;

  @override
  void initState() {
    _userRegisterBloc = get<UserRegisterBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserRegisterBloc, RegisterFormState>(
        listener: (context, state) {
      if (state is UserRegisterSuccessState) {
        context.go('/main');
      }
    },
    child: BlocBuilder<UserRegisterBloc, RegisterFormState>(
        builder: (context, state) {
          return BebrasScaffold(
            avoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 30.0, right: 16.0),
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      Assets.bebrasPandaiText,
                      height: 40,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Detail Akun',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField('Email', (value) {
                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(EmailEvent(email: BlocFormItem(value: value!)));
                    }, (val) {
                      return state.email.error;
                    },),
                    CustomTextField('Nama', (value) {
                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(NameEvent(name: BlocFormItem(value: value!)));
                    }, (val) {
                      return state.name.error;
                    },),
                    CustomDatePicker('Tanggal Lahir', (value) {
                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(BirthDateEvent(birthDate: BlocFormItem(
                          value: value!)));
                    }, (val) {
                      return state.birth_date.error;
                    }),
                    CustomTextField('Sekolah', (value) {
                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(SchoolEvent(school: BlocFormItem(
                          value: value!)));
                    }, (val) {
                      return state.school.error;
                    }),
                    ProvinceDropdown('Provinsi', (value) {
                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(ProvinceEvent(province: BlocFormItem(
                          value: value!)));
                    }, (val) {
                      return state.province.error;
                    }),
                    BiroBebrasDropdown('Bebras Biro', (value) {
                      BlocProvider.of<UserRegisterBloc>(context)
                          .add(BebrasBiroEvent(bebras_biro: BlocFormItem(
                          value: value!)));
                    }, (val) {
                      return state.bebras_biro.error;
                    }),
                    SizedBox(height: 20.0),
                    BlocConsumer<UserRegisterBloc, RegisterFormState>(
                        bloc: _userRegisterBloc,
                        listener: (context, state) {
                          if (state is UserRegisterSuccessState) {
                            context.go('/main');
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
                                BlocProvider.of<UserRegisterBloc>(context)
                                    .add(const FormSubmitEvent());
                                // context.go('/main');
                              }
                            },
                            child: Text('Daftar', style: TextStyle(fontWeight: FontWeight.w600),),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
