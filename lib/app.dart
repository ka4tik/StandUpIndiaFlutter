import 'package:flutter/material.dart';
import 'package:standup_india/scoped_models/app_model.dart';
import 'package:standup_india/widgets/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

class CinematicApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => MaterialApp(
            title: 'Standup India',
            theme: model.theme,
            home: HomePage(),
          ),
    );
  }
}
