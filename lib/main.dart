import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/di/locator.dart';
import 'features/posts/data/local_adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await registerHiveAdapters();
  await configureDependencies();

  runApp(const KabtourApp());
}
