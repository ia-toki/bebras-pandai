import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../modal/materialDocument.dart';

@Injectable()
class RegisterUserRepository {
  final _firecloud = FirebaseFirestore.instance.collection('materials');

  Future<MaterialDocument?> fetchDocument({
    required String docId,
  }) async {
    try {
      return await _firecloud.doc(docId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        return MaterialDocument.fromJson(documentSnapshot.data());
      });
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