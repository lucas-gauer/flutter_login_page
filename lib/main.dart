import 'package:flutter/material.dart';
import 'package:flutter_login_page/main.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:flutter_login_page/auth_service.dart';

import 'login_controller.dart';

const rightUsername = 'usernamecriativo';
const rightPassword = 'senh@criativa123';

@GenerateMocks([AuthService])
void main() {
  final authService = MockAuthService();

  //* mocks

  when( authService.login(any, any) ).thenReturn(false);

  when(
    authService.login(rightUsername, rightPassword)
  ).thenReturn(true);

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>.value(value: authService),
        // add more services here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(
      serviceLocator: context.read,
    );

    controller.addListener(stateListener);
  }

  void stateListener() {
    switch (controller.state) {
      case LoginPageState.input:
        return;
      case LoginPageState.success:
        showMessage('Login realizado', Colors.green);
        break;
      case LoginPageState.fail:
        showMessage('Credenciais inválidas', Colors.red);
        break;
    }
  }

  void showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>.value(
      value: controller,
      child: Scaffold(
        appBar: AppBar(title: const Text('Login'),),
        body: Center(
          child: SizedBox(
            height: 256,
            width: 512,
            child: Card(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [

                    //* username
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UsernameFormField(),
                    ),

                    //* password
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PasswordFormField(),
                    ),

                    //* button
                    Expanded(
                      child: Center(
                        child: LoginButton(),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UsernameFormField extends StatelessWidget {
  const UsernameFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();

    return TextFormField(
      validator: controller.fieldValidator,
      style: Theme.of(context).textTheme.headline6,
      decoration: const InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Usuário',
        hintText: rightUsername,
      ),
      onSaved: (user) {
        if (user != null)
          controller.data.username = user;
      },
    );
  }
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();

    return TextFormField(
      obscureText: true,
      validator: controller.fieldValidator,
      style: Theme.of(context).textTheme.headline6,
      decoration: const InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Senha',
        hintText: rightPassword,
      ),
      onSaved: (password) {
        if (password != null)
          controller.data.password = password;
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 128,
      child: ElevatedButton(
        onPressed: controller.onLogin,
        child: Text(
          'Login',
          style: textTheme.headline6!.copyWith(
            color: Colors.white,
          ),
        ),
      )
    );
  }
}
