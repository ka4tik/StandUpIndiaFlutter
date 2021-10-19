// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:standup_india/scoped_models/app_model.dart';

import 'app.dart';

void main() async {

  runApp(ScopedModel<AppModel>(
      model: AppModel(), child: CinematicApp()));
}
