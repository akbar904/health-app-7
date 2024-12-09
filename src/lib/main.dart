import 'package:flutter/material.dart';
import 'app/app.locator.dart';
import 'app/app.dialogs.dart';
import 'features/app/app_view.dart';

void main() {
  setupLocator();
  setupDialogUi();
  runApp(const AppView());
}
