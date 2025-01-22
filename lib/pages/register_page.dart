import 'package:belajar_mobile/components/login_animation.dart';
import 'package:belajar_mobile/components/my_button.dart';
import 'package:belajar_mobile/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up
  void signUpUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try creating the user
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle
        Navigator.pop(context);
      } else {
        // pop the loading circle
        Navigator.pop(context);
        // show error message, password don't match
        showErrorMessage('Password don\'t match!');
      }
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  // wrong message to user
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Center(
                child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWide =
                    constraints.maxWidth > 600; // Check for tablet view
                double paddingValue =
                    isWide ? 50 : 20; // Adjust padding based on screen size
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: paddingValue, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      // Animation
                      AnimatedHeart(),
                      const SizedBox(height: 50),
                      // welcome message
                      Text(
                        'Let\'s create an account for you',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 16),
                      ),
                      const SizedBox(height: 25),
                      // username textfield
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 400), // Limit width
                        child: MyTextfield(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // password textfield
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 400), // Limit width
                        child: MyTextfield(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // confirm password textfield
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 400), // Limit width
                        child: MyTextfield(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // sign up button
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: MyButton(
                          text: 'Sign Up',
                          onTap: signUpUser,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Already have an account section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Login now',
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
