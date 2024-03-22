import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bases/enum/button_type.dart';
import '../../../../core/bases/widgets/atoms/button.dart';
import '../../../../core/bases/widgets/atoms/html_cached_image.dart';
import '../../../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/status_task_set.dart';
import '../../../../core/theme/font_theme.dart';
import '../../../quiz_exercise/presentation/bloc/quiz_exercise_cubit.dart';
import '../../../quiz_exercise/presentation/model/quiz_exercise.dart';
import '../../../quiz_exercise/presentation/pages/task_dialog.dart';
import '../bloc/task_detail_cubit.dart';

part 'task_detail_page.dart';
part 'task_view_detail_page.dart';
