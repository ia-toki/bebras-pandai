import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../services/firebase_service.dart';

@injectable
class MaterialRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  MaterialRepository() {
    db.settings = FirebaseService.settings;
  }

  Stream<QuerySnapshot> getListMaterials() {
    try {
      return db.collection('learning_material').snapshots();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': '${e.message}'");
      }
      return const Stream.empty();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
