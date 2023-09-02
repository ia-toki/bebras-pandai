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

  static FirebaseAuth auth() {
    return FirebaseAuth.instanceFor(app: app);
  }
}
