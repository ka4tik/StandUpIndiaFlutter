import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:standup_india_flutter/theme.dart';

import 'HomeScreen.dart';
import 'RouteGenerator.dart';
import 'globals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quick Credit App',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Globals.scaffoldMessengerKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: HomeScreen.id,
      theme: AppTheme,
    );
  }
}
