import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_login_page/auth_service.dart';


enum LoginPageState {
  input, fail, success
}

class LoginPageData {
  String username = '';
  String password = '';
}

class LoginController extends ChangeNotifier {
  LoginController(
    {required Locator serviceLocator}
  ) : _serviceLocator = serviceLocator;

  final formKey = GlobalKey<FormState>();
  final Locator _serviceLocator;

  LoginPageState _state = LoginPageState.input;
  LoginPageState get state => _state;

  final data = LoginPageData();

  // TODO create validator for each field
  String? fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo!';
    }
  }

  void onLogin() {
    final form = formKey.currentState!;

    bool isValid = form.validate();
    if (!isValid) return;

    form.save();

    final authService = _serviceLocator<AuthService>();

    // TODO try catch
    bool success = authService.login(data.username, data.password);

    _state = success ? LoginPageState.success : LoginPageState.fail;
    notifyListeners();
  }
}
