import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetestproject/core/auth/login_or_register.dart';
import 'package:firebasetestproject/pages/home.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
