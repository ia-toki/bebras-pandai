import 'package:flutter/material.dart';

import 'app.dart';
import 'services/di.dart';
import 'services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await FirebaseService.initialize();
  runApp(const App());
}
