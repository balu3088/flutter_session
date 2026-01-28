import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final TextEditingController? controller;

  CustomTextField(
    this.labelText,
    this.hintText,
    this.obscureText,
    this.controller,
  );

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisibility = false;
  @override
  void initState() {
    super.initState();
    if (widget.obscureText == true) {
      passwordVisibility = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: passwordVisibility,
      decoration: InputDecoration(
          hintText: widget.hintText,
          suffix: widget.obscureText == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisibility = !passwordVisibility;
                    });
                  },
                  icon: Icon(!passwordVisibility
                      ? Icons.visibility
                      : Icons.visibility_off))
              : SizedBox(),
          labelText: widget.labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
    );
  }
}
