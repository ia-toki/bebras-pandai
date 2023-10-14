part of '_pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // late final SignInBloc _signInBloc;
  TextEditingController dateinput = TextEditingController();
  String? selectedValue = null;

  @override
  void initState() {
    // _signInBloc = get<SignInBloc>();

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget buildTextField(String labelText) {
    return Container(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          style: TextStyle(fontSize: 12.0),
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldDatePicker(String labelText) {
    return Container(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: dateinput,
          style: TextStyle(fontSize: 12.0, color: Colors.black),
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          readOnly: true,
          //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);

              setState(() {
                dateinput.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      ),
    );
  }

  List<BebrasBiro> get dropdownItems {
    var list = bebrasBiroList.where((el) => el.isActive).toList();
    // List<DropdownMenuItem<String>>
    var menuItems = list
        .map((element) => BebrasBiro(
          bebrasBiroUniv: element.bebrasBiroUniv,
          valueDropdown: element.valueDropdown,
          isActive: element.isActive,),
        ).toList();
    return menuItems;
  }

  Future<List<BebrasBiro>> getData(filter) async {
    // var response = await Dio().get(
    //   "https://63c1210999c0a15d28e1ec1d.mockapi.io/users",
    //   queryParameters: {"filter": filter},
    // );

    // final data = bebrasBiroList;
    // if (data != null) {
    //   return UserModel.fromJsonList(data);
    // }

    return bebrasBiroList;
  }

  Widget buildDropdown(String labelText) {
    return Container(
      height: 105.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownSearch<BebrasBiro>(
          asyncItems: (String filter) => getData('filter'),
          itemAsString: (BebrasBiro bebras) => bebras.userAsString(),
          compareFn: (item, item2) => item == item2,
          // dropdownBuilder: _customDropDownExampleMultiSelection,
            // print(item);
            // print(item2);
            // item.i(item2),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            showSelectedItems: true,
            // disabledItemFn: (String s) => s.startsWith('I'),
          ),
          items: dropdownItems,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: labelText,
              hintText: labelText,
            ),
          ),
          onChanged: print,
          selectedItem: null,
        ),
        // DropdownButtonFormField(
        //   style: TextStyle(color: Colors.orange),
        //   decoration: InputDecoration(
        //     labelText: labelText,
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.blue, width: 2),
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     border: OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.blue, width: 2),
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     // filled: true,
        //     // fillColor: Colors.blueAccent,
        //   ),
        //   validator: (value) => value == null ? "Select a country" : null,
        //   dropdownColor: Colors.blueAccent,
        //   value: selectedValue,
        //   onChanged: (String? newValue) {
        //     print(newValue);
        //     setState(() {
        //       selectedValue = newValue!;
        //     });
        //   },
        //   items: dropdownItems,
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 30.0, right: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.bebrasPandaiText,
              ),
              buildTextField('Field Name'),
              buildTextField('Email'),
              buildTextField('Nama'),
              buildTextFieldDatePicker('TTL'),
              buildTextField('Sekolah'),
              buildTextField('Provinsi'),
              // buildTextField('Bebas Biro'),
              buildDropdown('Bebras Biro'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
