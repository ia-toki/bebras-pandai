import 'package:flutter/material.dart';

import '../model/validation_form_model.dart';

extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isNotNull {
    // ignore: unnecessary_null_comparison
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^\+?0[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }
}

class FormProvider extends ChangeNotifier {
  ValidationFormModel _email = ValidationFormModel(null, null);
  ValidationFormModel _name = ValidationFormModel(null, null);
  final ValidationFormModel _birthDate = ValidationFormModel(null, null);
  ValidationFormModel _school = ValidationFormModel(null, null);
  ValidationFormModel _province = ValidationFormModel(null, null);
  ValidationFormModel _bebrasBiro = ValidationFormModel(null, null);

  ValidationFormModel get email => _email;
  ValidationFormModel get name => _name;
  ValidationFormModel get birthDate => _birthDate;
  ValidationFormModel get school => _school;
  ValidationFormModel get province => _province;
  ValidationFormModel get bebrasBiro => _bebrasBiro;

  void validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      _email = ValidationFormModel(val, null);
    } else {
      _email =
          ValidationFormModel(null, 'Mohon mengisi e-mail terlebih dahulu!');
    }
    notifyListeners();
  }

  void validateName(String? val) {
    if (val != null && val.isValidName) {
      _name = ValidationFormModel(val, null);
    } else {
      _name = ValidationFormModel(null, 'Mohon mengisi nama terlebih dahulu!');
    }
    notifyListeners();
  }

  void validateSchool(String? val) {
    if (val != null) {
      _school = ValidationFormModel(val, null);
    } else {
      _school = ValidationFormModel(
        null,
        'Mohon mengisi nama sekolah terlebih dahulu!',
      );
    }
    notifyListeners();
  }

  void validateProvince(String? val) {
    if (val != null) {
      _province = ValidationFormModel(val, null);
    } else {
      _province = ValidationFormModel(
        null,
        'Mohon mengisi nama provinsi terlebih dahulu!',
      );
    }
    notifyListeners();
  }

  void validateBebrasBiro(String? val) {
    if (val != null) {
      _bebrasBiro = ValidationFormModel(val, null);
    } else {
      _bebrasBiro = ValidationFormModel(
        null,
        'Mohon mengisi bebras biro terlebih dahulu!',
      );
    }
    notifyListeners();
  }

  bool get validate {
    return _email.value != null &&
        _name.value != null &&
        _birthDate.value != null &&
        _school.value != null &&
        _province.value != null &&
        _bebrasBiro.value != null;
  }
}
