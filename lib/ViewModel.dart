import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'userModel.dart';

class ViewModel extends ChangeNotifier {
  //Насколько я понял вью модель не должна хранить в себе какой либо стейт
  //Но я всё равно храню тут стейт который напрямую влияет на отображение
  //Вроде, это не правильно, но ничего получше придумать не смог
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final storage = FlutterSecureStorage();
  bool isLoading = false;
  User currentUser;

  //Calls once when app starts
  void tryToLogInWithStorageToken() async {
    String _token = await storage.read(key: 'token');
    if (_token != null && currentUser == null) {
      isLoading = true;
      var _userData = await User.getUserData(_token);
      switch (_userData) {
        case 'unauthorised':
          {
            Fluttertoast.showToast(
                msg: 'Токен протух, намагаюсь отримати новий');
            //Наверное, тут бы хорошо смотрелась функция рефреш токин
            break;
          }
        case 'unknown':
          {
            Fluttertoast.showToast(
                msg: 'Невідома помилка при переаутентифікації');
            break;
          }
        default:
          {
            //Создаю нового локального юзера если всё норм с токеном
            Fluttertoast.showToast(msg: 'Автоматично переаутентифіковано');
            currentUser = User.login(_token, _userData);
          }
      }
      isLoading = false;
      notifyListeners();
    }
  }

  //Logs user in with email and password
  void logIn() async {
    isLoading = true;
    String _token = await User.getTokenViaEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    //Обрабатываю ошибки и вовзвращаю локального юзера если всё норм
    switch (_token) {
      case 'validation_error':
        {
          Fluttertoast.showToast(
            msg: 'Хибно введений логін чи пароль',
          );
          break;
        }
      case 'wrong_email_or_password':
        {
          Fluttertoast.showToast(
            msg:
                'Данний користувач не зареєстрований на платформі, або пароль не вірний',
          );
          break;
        }
      case 'unhandled_error':
        {
          Fluttertoast.showToast(
            msg: 'Виникла помилка на сервері, спробуйте через деякий час',
          );
          break;
        }
      default:
        {
          Map<String, dynamic> _userData = await User.getUserData(_token);
          currentUser = User.login(_token, _userData);
          await storage.write(key: 'token', value: currentUser.tokenData);
          emailController.clear();
          passwordController.clear();
          isLoading = false;
          notifyListeners();
        }
    }
  }

  //Deletes user
  void getRidOfUser() async {
    isLoading = true;
    currentUser = null;
    await storage.delete(key: 'token');
    isLoading = false;
    notifyListeners();
  }
}
