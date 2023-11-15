import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/bases/enum/button_type.dart';
import '../../../../core/bases/widgets/atoms/button.dart';
import '../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/font_theme.dart';
import '../../../authentication/register/presentation/widgets/custom_text_field.dart';
import '../../../quiz_registration/presentation/bloc/quiz_registration_cubit.dart';
import '../../../quiz_start/presentation/bloc/quiz_start_cubit.dart';
import '../bloc/quiz_exercise_cubit.dart';

part 'quiz_exercise_page.dart';
