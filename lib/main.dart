import 'package:flutter/material.dart';
import 'package:flutter_login_page/main.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_login_page/auth_service.dart';

const rightUsername = 'usernamecriativo';
const rightPassword = 'senh@criativa123';

// ! this should be managed differently
final authService = MockAuthService();

@GenerateMocks([AuthService])
void main() {
  //* mocks
  
  when( authService.login(any, any) ).thenReturn(false);

  when(
    authService.login(rightUsername, rightPassword)
  ).thenReturn(true);

  runApp(const MyApp());
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
  final formKey = GlobalKey<FormState>();

  String user = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Login'),),
      body: Center(
        child: SizedBox(
          height: 256,
          width: 512,
          child: Card(
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  //* username
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: fieldValidator,
                      style: textTheme.headline6,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Usuário',
                        hintText: rightUsername,
                      ),
                      onSaved: (user) {
                        if (user != null)
                          this.user = user;
                      },
                    ),
                  ),

                  //* password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: fieldValidator,
                      style: textTheme.headline6,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Senha',
                        hintText: rightPassword,
                      ),
                      onSaved: (password) {
                        if (password != null)
                          this.password = password;
                      },
                    ),
                  ),

                  //* button
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 128,
                        child: ElevatedButton(
                          onPressed: onLogin,
                          child: Text(
                            'Login',
                            style: textTheme.headline6!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

    bool success = authService.login(user, password);
    print(success);

    // TODO show if successful
  }
}
