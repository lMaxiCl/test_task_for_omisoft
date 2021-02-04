import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_for_omisoft/ViewModel.dart';

class MainAppScreen extends StatelessWidget {
  static const String id = 'MAIN_APP_SCREEN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Інформація про користувача(Якщо все працює)'),
            Text("Ім'я: " +
                Provider.of<ViewModel>(context).currentUser.firstName),
            Text('Прізвище: ' +
                Provider.of<ViewModel>(context).currentUser.lastName),
            Text('Електронна пошта: ' +
                Provider.of<ViewModel>(context).currentUser.email),
            RaisedButton(
              child: Text('Повернутись'),
              onPressed: () {
                Provider.of<ViewModel>(context, listen: false).getRidOfUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
