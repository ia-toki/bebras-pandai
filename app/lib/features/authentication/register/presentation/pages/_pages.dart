import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/theme/font_theme.dart';
import '../../../../../services/di.dart';
import '../../../../main/presentation/bloc/main_cubit.dart';
import '../../bloc/user_register_bloc.dart';
import '../../model/form_item.dart';
import '../widgets/biro_bebras_dropdown.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/province_dropdown.dart';

part 'register_page.dart';
