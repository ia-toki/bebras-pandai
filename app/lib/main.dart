import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api/firebase_api.dart';
import 'app.dart';
import 'services/di.dart';
import 'services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  configureDependencies();
  await FirebaseService.initialize();
  await FirebaseApi().initNotifications();
  runApp(const App());
}
