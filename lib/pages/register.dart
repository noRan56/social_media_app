import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetestproject/core/components/app_buttons.dart';
import 'package:firebasetestproject/core/components/app_text_field.dart';
import 'package:firebasetestproject/core/helpers/error.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final void Function()? onTap;

  Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

// class _RegisterState extends State<Register> {
//   final TextEditingController emailController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();

//   final TextEditingController userNameController = TextEditingController();

//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   void register() async {
//     showDialog(
//       context: context,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );

//     if (passwordController.text != confirmPasswordController.text) {
//       Navigator.pop(context);
//       displayMessage("Password don't match", context);
//     }
//     UserCredential? userCredential;
//     try {
//       createUserDocument(userCredential);
//       if (context.mounted) Navigator.pop(context);
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);

//       displayMessage(e.code, context);
//     }
//   }

//   Future<void> createUserDocument(UserCredential? userCredential) async {
//     if (userCredential != null && userCredential.user != null) {}
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userCredential!.user!.email)
//         .set({
//       'email': userCredential.user!.email,
//       'username': userNameController.text
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 180),
//                 Icon(Icons.dangerous,
//                     color: Theme.of(context).colorScheme.surface),
//                 const SizedBox(height: 10),
//                 AppTextField(
//                     hintText: "userName",
//                     obsecureText: false,
//                     controller: userNameController),
//                 const SizedBox(height: 13),
//                 AppTextField(
//                     hintText: "E-mail",
//                     obsecureText: false,
//                     controller: emailController),
//                 const SizedBox(height: 13),
//                 AppTextField(
//                     hintText: "password",
//                     obsecureText: true,
//                     controller: passwordController),
//                 const SizedBox(height: 10),
//                 AppTextField(
//                     hintText: " Confirm Password",
//                     obsecureText: true,
//                     controller: confirmPasswordController),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text("Forget Password?",
//                         style: TextStyle(
//                             color: Theme.of(context).colorScheme.inversePrimary,
//                             fontSize: 16)),
//                   ],
//                 ),
//                 const SizedBox(height: 13),
//                 AppButtons(text: 'Register', onTap: register),
//                 const SizedBox(height: 15),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an account?",
//                         style: TextStyle(
//                             color: Theme.of(context).colorScheme.inversePrimary,
//                             fontSize: 16)),
//                     GestureDetector(
//                       onTap: widget.onTap,
//                       child: const Text(
//                         "Register Now",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void register() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Validate password confirmation
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context); // Close loading indicator
      displayMessage("Passwords don't match", context);
      return; // Stop further execution
    }

    try {
      // Firebase user registration
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Create user document in Firestore
      await createUserDocument(userCredential);

      if (context.mounted) Navigator.pop(context); // Close loading indicator
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading indicator
      displayMessage(e.code, context); // Display error message
    }
  }

  Future<void> createUserDocument(UserCredential userCredential) async {
    // Add user information to Firestore
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userCredential.user!.uid)
        .set({
      'email': userCredential.user!.email,
      'username': userNameController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text("W E L C O M E "),
                const SizedBox(height: 40),
                AppTextField(
                    hintText: "Username",
                    obsecureText: false,
                    controller: userNameController),
                const SizedBox(height: 13),
                AppTextField(
                    hintText: "E-mail",
                    obsecureText: false,
                    controller: emailController),
                const SizedBox(height: 13),
                AppTextField(
                    hintText: "Password",
                    obsecureText: true,
                    maxLine: 1,
                    controller: passwordController),
                const SizedBox(height: 10),
                AppTextField(
                    hintText: "Confirm Password",
                    obsecureText: true,
                    maxLine: 1,
                    controller: confirmPasswordController),
                const SizedBox(height: 10),
                AppButtons(text: 'Register', onTap: register),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 16)),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Login Now",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
