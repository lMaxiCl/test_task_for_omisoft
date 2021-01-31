import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_for_omisoft/Screens/LogInScreen.dart';
import 'package:test_task_for_omisoft/Screens/MainScreen.dart';

import 'AppData.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final AppData _data = AppData();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppData>(
      create: (context) => _data,
      child: MaterialApp(
        title: 'Test task for OmiSoft',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Root(),
      ),
    );
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<AppData>(context).tokenData == null
        ? LogInScreen()
        : MainAppScreen();
  }
}
