import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetestproject/core/auth/auth.dart';
import 'package:firebasetestproject/core/components/app_buttons.dart';
import 'package:firebasetestproject/core/components/app_text_field.dart';
import 'package:firebasetestproject/core/helpers/error.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;

  Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

// class _LoginState extends State<Login> {
//   final TextEditingController emailController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();

//   void login() async {
//     showDialog(
//       context: context,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController.text, password: passwordController.text);
//       if (context.mounted) Navigator.pushReplacementNamed(context, '/authpage');
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);

//       displayMessage(e.code, context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               const SizedBox(height: 180),
//               Icon(Icons.person,
//                   size: 80, color: Theme.of(context).colorScheme.surface),
//               const SizedBox(height: 10),
//               AppTextField(
//                   hintText: "userName",
//                   obsecureText: false,
//                   controller: emailController),
//               const SizedBox(height: 13),
//               AppTextField(
//                   hintText: "password",
//                   obsecureText: true,
//                   controller: passwordController),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text("Forget Password?",
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                           fontSize: 16)),
//                 ],
//               ),
//               const SizedBox(height: 13),
//               AppButtons(text: 'Login', onTap: () {}),
//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account?",
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                           fontSize: 16)),
//                   GestureDetector(
//                     onTap: widget.onTap,
//                     child: const Text(
//                       "Register Now",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Firebase user login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'home');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading indicator
      displayMessage(e.code, context); // Display error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 180),
              Icon(Icons.person,
                  size: 80, color: Theme.of(context).colorScheme.surface),
              const SizedBox(height: 10),
              AppTextField(
                  hintText: "E-mail",
                  obsecureText: false,
                  controller: emailController),
              const SizedBox(height: 13),
              AppTextField(
                  hintText: "Password",
                  maxLine: 1,
                  obsecureText: true,
                  controller: passwordController),
              const SizedBox(height: 10),
              AppButtons(text: 'Login', onTap: login), // Call login method
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16)),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Register Now",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
