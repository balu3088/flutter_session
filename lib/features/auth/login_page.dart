import 'package:batch_four_exp/common/components/custom_text_field.dart';
import 'package:batch_four_exp/common/components/cutom_button.dart';
import 'package:batch_four_exp/features/auth/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool passwordVisibility = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Listen to auth controller changes
    ref.listen(authController, (previous, next) {
      next.when(
        data: (authResponse) {
          // Check if auth token is not empty
          if (authResponse.authToken.isNotEmpty) {
            // Redirect to home if token exists
            Navigator.pushReplacementNamed(context, '/home',
                arguments: {"title": authResponse.userId ?? "User", "id": 123});
          } else {
            // Show error if credentials are invalid

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(authResponse.error ?? 'Invalid credentials')),
            );
          }
        },
        loading: () {
          const Center(
            child: const CircularProgressIndicator(),
          );
          // const CircularProgressIndicator();
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        },
      );
    });

    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            )),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: constrains.maxHeight * 0.5,
                    width: constrains.maxWidth * 0.5,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField("Email", "Enter Email", false, _email),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField(
                            "Password", "Enter Password", true, _password),
                        const SizedBox(
                          height: 15.0,
                        ),
                        CustomButton("Login", () {
                          ref.read(authController.notifier).login(
                                _email.text.toString(),
                                _password.text.toString(),
                              );
                        })
                      ],
                    ))
              ],
            ))
          ],
        );
      }),
    );
  }
}
