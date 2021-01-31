import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_for_omisoft/AppData.dart';

class MainAppScreen extends StatelessWidget {
  static const String id = 'MAIN_APP_SCREEN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Просто текст, чтобы проверить что токен работает
          Text(Provider.of<AppData>(context).someData),
          RaisedButton(
            child: Text('Return'),
            onPressed: () {
              Provider.of<AppData>(context, listen: false).getRidOfToken();
            },
          )
        ],
      ),
    );
  }
}
