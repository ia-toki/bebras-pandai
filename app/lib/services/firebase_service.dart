import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';
import 'app_logger.dart';

class FirebaseService {
  static late FirebaseApp app;
  static Future<void> initialize() async {
    app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    AppLogger.d('Initialized app $app');
  }

  static const Settings settings = Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  static FirebaseAuth auth() {
    return FirebaseAuth.instanceFor(app: app);
  }
}
