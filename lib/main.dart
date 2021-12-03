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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  //* username
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: textTheme.headline6,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Usuário',
                        hintText: 'usernamecriativo'
                      ),
                    ),
                  ),

                  //* password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: textTheme.headline6,
                      decoration: const InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Senha',
                        hintText: 'senh@criativa123',
                      ),
                    ),
                  ),

                  //* button
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 128,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO
                          },
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
}
