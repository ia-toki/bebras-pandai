import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/bases/enum/button_type.dart';
import '../../../../../core/bases/widgets/atoms/button.dart';
import '../../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/bebrasBiroDropdown.dart';
import '../../../../../core/constants/colorConstant.dart';
import '../../../../../core/constants/indonesiaProvince.dart';
import '../../../../../services/di.dart';
// import '../bloc/sign_in_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../bloc/user_register_bloc.dart';
import '../../model/form_item.dart';
import '../../repositories/register_user_repo.dart';
import '../widgets/biro_bebras_dropdown.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/province_dropdown.dart';

part 'register_page.dart';
