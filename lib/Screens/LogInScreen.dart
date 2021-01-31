import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:test_task_for_omisoft/AppData.dart';

class LogInScreen extends StatelessWidget {
  static const String id = 'LOG_IN_SCREEN';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Увійдіть\nщоб продовжити',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: TextButton(
                      onPressed: () =>
                          Fluttertoast.showToast(msg: 'Sign in with Facebook!'),
                      child: Text(
                        'Facebook',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () =>
                          Fluttertoast.showToast(msg: 'Sign in with Google!'),
                      child: Text(
                        'Google',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Text('або'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(hintText: 'Поштова скринька'),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(hintText: 'Пароль'),
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
              ),
            ),
            TextButton(
              onPressed: () => Fluttertoast.showToast(msg: 'Правда забули?'),
              child: Text(
                'Забули пароль?',
                style:
                    TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Provider.of<AppData>(context, listen: false).getToken(
                            _emailController.text, _passwordController.text);
                        _emailController.clear();
                        _passwordController.clear();
                      },
                      child: Text(
                        'Увійти',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
