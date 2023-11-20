import 'package:flutter/material.dart';

import 'app.dart';
import 'core/params/service_locator.dart';

void main() async {
  await serviceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
