import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'services/di.dart';
import 'services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  configureDependencies();
  await FirebaseService.initialize();
  runApp(const App());
}
