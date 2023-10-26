import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../model/registered_user.dart';
@Injectable()
class RegisterUserRepository {
  final _firecloud = FirebaseFirestore.instance.collection('registered_user');

  Future<void> create({
    required String userId,
    required dynamic email,
    required String name,
    required String birth_date,
    required String school,
    required String province,
    required String bebras_biro,
  }) async {
    try {
      await _firecloud.doc(userId)
          .set({
            'name': name,
            'email': email,
            'birth_date': birth_date,
            'school': school,
            'province': province,
            'bebras_biro': bebras_biro,
          },
          SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<RegisteredUserModel>> getAll() async {
    final registeredUserList = <RegisteredUserModel>[];
    try {
      final result = await FirebaseFirestore.instance.collection('registered_user').get();

      for (final element in result.docs) {
        continue;
      }
      return registeredUserList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
      return registeredUserList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RegisteredUserModel?> getById(String userId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('registered_user')
          .doc(userId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              return documentSnapshot;
            }
        });
      if(result != null) {
        return RegisteredUserModel.fromJson(result);
      } else {
        return null;
      }

    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}