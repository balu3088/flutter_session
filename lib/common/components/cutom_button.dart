import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btName;
  final VoidCallback onPressedallback;
  CustomButton(this.btName, this.onPressedallback);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressedallback,
        child: Text(
          btName,
        ),
        style: OutlinedButton.styleFrom(fixedSize: Size(450, 50)));
  }
}
