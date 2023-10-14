import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../model/registered_user.dart';
@Injectable()
class RegisterUserRepository {
  final _firecloud = FirebaseFirestore.instance.collection('registered_user');

  Future<void> create({
    required String email,
    required String name,
    required DateTime birth_date,
    required String school,
    required String province,
    required String bebras_biro,
  }) async {
    try {
      await _firecloud.add({"name": name, "email": email, });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<RegisteredUserModel>> getAll() async {
    List<RegisteredUserModel> registeredUserList = [];
    try {
      final result = await FirebaseFirestore.instance.collection("registered_user").get();

      result.docs.forEach((element) {
        return registeredUserList.add(RegisteredUserModel.fromJson(element.data()));
      });
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
          .collection("registered_user").doc(userId).get();

      return RegisteredUserModel.fromJson(result as Map<String, dynamic>);
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