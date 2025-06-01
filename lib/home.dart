import 'package:firebasetestproject/core/auth/auth.dart';
import 'package:firebasetestproject/core/auth/login_or_register.dart';
import 'package:firebasetestproject/core/theme/dark_mode.dart';
import 'package:firebasetestproject/core/theme/light_mode.dart';
import 'package:firebasetestproject/pages/home.dart';
import 'package:firebasetestproject/pages/login.dart';
import 'package:firebasetestproject/pages/profile.dart';
import 'package:firebasetestproject/pages/register.dart';
import 'package:firebasetestproject/pages/users.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: LightModeTheme,
      darkTheme: DarkModeTheme,
      routes: {
        'authpage': (context) => const AuthPage(),
        'home': (context) => Home(),
        'profile': (context) => Profile(),
        'users': (context) => Users(),
        'register': (context) => Register(
              onTap: () {},
            ),
      },
    );
  }
}
