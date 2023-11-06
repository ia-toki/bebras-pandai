import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../model/registered_user.dart';

@Injectable()
class RegisterUserRepository {
  final _firecloud = FirebaseFirestore.instance.collection('registered_user');
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  Future<void> create({
    required String userId,
    required dynamic email,
    required String name,
    required String birthDate,
    required String school,
    required String province,
    required String bebrasBiro,
    String? createdAt,
  }) async {
    try {
      await _firecloud.doc(userId).set(
        {
          'name': name,
          'email': email,
          'birth_date': birthDate,
          'school': school,
          'province': province,
          'bebras_biro': bebrasBiro,
          'created_at': createdAt,
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

  Future<void> update({
    required String userId,
    required dynamic email,
    required String name,
    required String birthDate,
    required String school,
    required String province,
    required String bebrasBiro,
    String? updatedAt,
  }) async {
    try {
      await _firecloud.doc(userId).set(
        {
          'name': name,
          'email': email,
          'birth_date': birthDate,
          'school': school,
          'province': province,
          'bebras_biro': bebrasBiro,
          'updated_at': updatedAt,
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
      final result =
          await FirebaseFirestore.instance.collection('registered_user').get();

      for (final element in result.docs) {
        registeredUserList.add(RegisteredUserModel.fromJson(element.data()));
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
      if (result != null) {
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
