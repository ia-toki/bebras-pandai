import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/bases/enum/button_type.dart';
import '../../../../core/bases/widgets/atoms/button.dart';
import '../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/theme/font_theme.dart';
import '../../../material/menu/presentation/pages/_pages.dart';
import '../bloc/home_cubit.dart';
import 'clip_path.dart';

part 'home_page.dart';
part 'setting_page.dart';
