// // ignore_for_file: lines_longer_than_80_chars

// part of '_pages.dart';

// class RegisterPageV2 extends StatefulWidget {
//   const RegisterPageV2({super.key, this.isUpdateProfile});

//   final String? isUpdateProfile;

//   @override
//   State<RegisterPageV2> createState() => _RegisterPageStateV2();
// }

// class _RegisterPageStateV2 extends State<RegisterPageV2> {
//   Future<void> showModal() {
//     return showModalBottomSheet<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//             return Container(
//               height: 206,
//               width: double.infinity,
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(left: 20),
//                     child: const Text(
//                       'Anda akan meninggalkan halaman ini. Data formulir tidak akan disimpan. Lanjutkan?',
//                       textAlign: TextAlign.left,
//                       style:
//                           TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     width: double.infinity,
//                     child: Button(
//                         customButtonColor: Color.fromARGB(255, 243, 238, 238),
//                         customTextColor: Colors.blue,
//                         text: 'Ya'),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     width: double.infinity,
//                     child: Button(
//                         customButtonColor: Color(0xFF1BB8E1),
//                         customTextColor: Colors.white,
//                         text: 'Tidak'),
//                   ),
//                 ],
//               ),
//             );
//           });
//         });
//   }

//   late final UserRegisterBloc _userRegisterBloc;
//   String? selectedValue;

//   @override
//   void initState() {
//     _userRegisterBloc = get<UserRegisterBloc>();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return BlocProvider(
//       create: (_) => get<UserRegisterBloc>()
//         ..add(
//           const InitialValueEvent(),
//         ),
//       child: BlocListener<UserRegisterBloc, RegisterFormState>(
//         listener: (context, state) {
//           if (state is UserRegisterSuccessState) {
//             if (widget.isUpdateProfile == 'true') {
//               // refresh page
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 // ignore: inference_failure_on_instance_creation
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       const RegisterPageV2(isUpdateProfile: 'true'),
//                 ),
//               );

//               context.read<HomeCubit>().fetchUser();

//               // add notification
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Pembaruan data profil berhasil'),
//                   behavior: SnackBarBehavior.floating,
//                 ),
//               );
//             } else {
//               context.go('/main');
//             }
//           }
//         },
//         child: BlocBuilder<UserRegisterBloc, RegisterFormState>(
//           builder: (context, state) {
//             return BebrasScaffold(
//               avoidBottomInset: false,
//               body: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 16,
//                   top: 20,
//                   right: 16,
//                 ),
//                 child: Form(
//                   key: state.formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               showModal();
//                             },
//                             child: Container(
//                               child: Icon(
//                                 Icons.arrow_back,
//                                 // color: Colors.blue,
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             child: GestureDetector(
//                               onTap: () async {
//                                 await context.push(
//                                   Uri(
//                                     path: '/register',
//                                     queryParameters: {
//                                       'isUpdateProfile': 'true',
//                                     },
//                                   ).toString(),
//                                 );
//                               },
//                               child: Container(
//                                 // width: double.infinity,
//                                 child: Center(
//                                   child: const Text(
//                                     'Edit Profile',
//                                     textAlign: TextAlign.start,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Column(children: [
//                         CircleAvatar(
//                           maxRadius: 50,
//                           backgroundImage: NetworkImage(
//                             Assets.bLogo,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         Text('Putri Nabila',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontWeight: FontWeight.w600)),
//                       ]),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       CustomTextFieldV2(
//                         'Email',
//                         (value) {
//                           BlocProvider.of<UserRegisterBloc>(context).add(
//                             EmailEvent(email: BlocFormItem(value: value)),
//                           );
//                         },
//                         (val) {
//                           return state.email.error;
//                         },
//                         state.email.value,
//                       ),
//                       CustomTextFieldV2(
//                         'Nama',
//                         (value) {
//                           BlocProvider.of<UserRegisterBloc>(context)
//                               .add(NameEvent(name: BlocFormItem(value: value)));
//                         },
//                         (val) {
//                           return state.name.error;
//                         },
//                         state.name.value,
//                       ),
//                       CustomTextFieldV2(
//                         'Tempat Lahir',
//                         (value) {
//                           // BlocProvider.of<UserRegisterBloc>(context).add(
//                           //   NameEvent(name: BlocFormItem(value: value)),
//                           // );
//                         },
//                         (val) {
//                           // return state.name.error;
//                           null;
//                         },
//                         null,
//                       ),
//                       CustomDatePickerV2(
//                         'Date',
//                         (value) {
//                           BlocProvider.of<UserRegisterBloc>(context).add(
//                             BirthDateEvent(
//                               birthDate: BlocFormItem(
//                                 value: value,
//                               ),
//                             ),
//                           );
//                         },
//                         (val) {
//                           return state.birthDate.error;
//                         },
//                         state.birthDate.value,
//                       ),
//                       CustomTextFieldV2(
//                         'Asal Sekolah',
//                         (value) {
//                           BlocProvider.of<UserRegisterBloc>(context).add(
//                             SchoolEvent(
//                               school: BlocFormItem(
//                                 value: value,
//                               ),
//                             ),
//                           );
//                         },
//                         (val) {
//                           return state.school.error;
//                         },
//                         state.school.value,
//                       ),
//                       ProvinceDropdownV2(
//                         'Provinsi',
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
//                             ? state.province.value
//                             : 'Provinsi',
//                       ),
//                       BiroBebrasDropdownV2(
//                         'Bebras Biro',
//                         (value) {
//                           BlocProvider.of<UserRegisterBloc>(context).add(
//                             BebrasBiroEvent(
//                               bebrasBiro: BlocFormItem(
//                                 value: value,
//                               ),
//                             ),
//                           );
//                         },
//                         (val) {
//                           return state.bebrasBiro.error;
//                         },
//                         state.bebrasBiro.value.isNotEmpty
//                             ? state.bebrasBiro.value
//                             : 'Bebras Biro',
//                       ),
//                       BlocConsumer<UserRegisterBloc, RegisterFormState>(
//                         bloc: _userRegisterBloc,
//                         listener: (context, state) {
//                           if (state is UserRegisterSuccessState) {
//                             if (widget.isUpdateProfile == 'true') {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: const Text(
//                                     'Profile data successfully updated',
//                                   ),
//                                   action: SnackBarAction(
//                                     label: 'OK',
//                                     onPressed: () {
//                                       // Some code to undo the change.
//                                     },
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               context.go('/main');
//                             }
//                           }
//                         },
//                         builder: (context, state) {
//                           return ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               fixedSize: Size(size.width, 45),
//                               backgroundColor: Colors.lightBlue,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (state is! UserRegisterLoadingState) {
//                                 if (widget.isUpdateProfile == 'true') {
//                                   BlocProvider.of<UserRegisterBloc>(context)
//                                       .add(const FormSubmitUpdateEvent());
//                                 } else {
//                                   BlocProvider.of<UserRegisterBloc>(context)
//                                       .add(const FormSubmitEvent());
//                                 }
//                               }
//                             },
//                             child: Text(
//                               widget.isUpdateProfile == 'true'
//                                   ? 'Perbarui'
//                                   : 'Daftar',
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.w600),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
