import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../../core/bases/widgets/layout/bottom_navbar.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../main/presentation/bloc/home_cubit.dart';
import '../../../../main/presentation/pages/clip_path.dart';
import '../../data/repositories/material.dart';
import '../model/bebras_group_category.dart';

part 'material_menu.dart';
