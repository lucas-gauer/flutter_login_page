import 'package:flutter/material.dart';
import 'package:flutter_login_page/main.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'login/login_credentials.dart';
import 'login/login_page.dart';
import 'auth_service.dart';

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
