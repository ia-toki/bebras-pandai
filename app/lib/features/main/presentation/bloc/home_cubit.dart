import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../services/firebase_service.dart';
import '../../../authentication/register/model/registered_user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchUser() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('registered_user')
          .doc(FirebaseService.auth().currentUser?.uid)
          .get();
      final userData = userSnapshot.data();
      if (userSnapshot.exists && userData != null) {
        emit(HomeSuccess(RegisteredUserModel.fromJson(userData)));
      } else {
        throw Exception('User Data cannot be extracted');
      }
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }
}
