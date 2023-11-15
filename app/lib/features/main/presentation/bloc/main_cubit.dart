import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../services/firebase_service.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  Future<void> fetchUser() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('registered_user')
          .doc(FirebaseService.auth().currentUser?.uid)
          .get();
      final userData = userSnapshot.data();
      if (userData != null) {
        emit(MainSuccess(userData));
      } else {
        throw Exception('User Data cannot be extracted');
      }
    } catch (e) {
      emit(MainFailed(e.toString()));
    }
  }
}
