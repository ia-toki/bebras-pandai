import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/bases/widgets/atoms/button.dart';
import '../../../../authentication/register/bloc/user_register_bloc.dart';
import '../../../../authentication/register/model/form_item.dart';
import '../../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/get_started.dart';
import '../../../../../core/theme/base_colors.dart';
import '../../../../../core/theme/font_theme.dart';
import '../../bloc/user_initialization_bloc.dart';
import './widgets/custom_text_field.dart';
import './widgets/province_dropdown.dart';

part 'onboarding_page.dart';
part 'splash_screen.dart';
part 'update_dialog.dart';
part 'register_page.dart';
