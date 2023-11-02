import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quiz_result_state.dart';

class QuizResultCubit extends Cubit<QuizResultState> {
  QuizResultCubit() : super(QuizResultInitial());
}
