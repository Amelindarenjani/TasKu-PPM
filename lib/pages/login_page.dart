import 'package:belajar_mobile/components/my_button.dart';
import 'package:belajar_mobile/components/my_textfield.dart';
import 'package:belajar_mobile/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in
  void signInUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
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
                      const SizedBox(height: 30),
                      // logo
                      const Icon(
                        Icons.lock,
                        size: 100,
                      ),
                      const SizedBox(height: 30),
                      // welcome message
                      Text(
                        'Welcome back you\'ve been missed!',
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
                      // forgot password link
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blue.shade700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // sign-in button
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 400), // Limit width
                        child: MyButton(
                          text: 'Log In',
                          onTap: signInUser,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Or continue with section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Or Continue With',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 0.5,
                              color: Theme.of(context).colorScheme.tertiary,
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Google and Email sign-in buttons
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTile(imagePath: 'lib/images/google.png'),
                          SizedBox(width: 10),
                          SquareTile(imagePath: 'lib/images/email.png'),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Register now section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Register now',
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
