import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_for_omisoft/Screens/LogInScreen.dart';
import 'package:test_task_for_omisoft/Screens/MainScreen.dart';

import 'ViewModel.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => ViewModel(),
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
    //Эта штука должна вызываться только 1 раз, но я не уверен, что она так работает
    Provider.of<ViewModel>(context).tryToLogInWithStorageToken();
    //
    if (Provider.of<ViewModel>(context).isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    //Проверяет юзера и выбирает что рендерить
    if (Provider.of<ViewModel>(context).currentUser != null) {
      return MainAppScreen();
    } else {
      return LogInScreen();
    }
  }
}
