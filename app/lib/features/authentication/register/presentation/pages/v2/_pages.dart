import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/bases/widgets/atoms/button.dart';
import '../../../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../../../core/constants/assets.dart';
import '../../../../../../../services/di.dart';
import '../../../../../main/presentation/bloc/home_cubit.dart';
import '../../../bloc/user_register_bloc.dart';
import '../../../model/form_item.dart';
import 'widgets/biro_bebras_dropdownV2.dart';
import 'widgets/custom_date_pickerV2.dart';
import 'widgets/custom_text_fieldV2.dart';
import 'widgets/province_dropdownV2.dart';

// part 'register_page.dart';
