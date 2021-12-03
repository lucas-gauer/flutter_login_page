import 'package:flutter/material.dart';

void main() {
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
                        hintText: 'usernamecriativo'
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
                        hintText: 'senh@criativa123',
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

    // TODO finish login
  }
}
