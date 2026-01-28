import 'package:batch_four_exp/common/components/custom_text_field.dart';
import 'package:batch_four_exp/common/components/cutom_button.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisibility = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField("Email", "Enter Email", false, _email),
                        SizedBox(
                          height: 10.0,
                        ),
                        CustomTextField(
                            "Password", "Enter Password", true, _password),
                        SizedBox(
                          height: 15.0,
                        ),
                        CustomButton("Login", () {
                          if (_email.text == "bk" && _password.text == "bk") {
                            Navigator.pushNamed(context, '/home',
                                arguments: {"title": "Example", "id": 123});
                          } else {
                            print("Invalid Credentials ");
                          }
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
