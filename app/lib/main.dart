import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  await initializeDateFormatting('id_ID');
  runApp(const App());
}
