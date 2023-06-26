import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCi2_NjRM36csHNrmY-zI-zE6oqJNMROJQ",
            authDomain: "toki-bebras-proto.firebaseapp.com",
            projectId: "toki-bebras-proto",
            storageBucket: "toki-bebras-proto.appspot.com",
            messagingSenderId: "267749218027",
            appId: "1:267749218027:web:76591e4102dc7deee950ae",
            measurementId: "G-4L8S00H4J4"));
  } else {
    await Firebase.initializeApp();
  }
}
