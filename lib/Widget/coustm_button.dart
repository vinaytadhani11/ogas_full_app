// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ogas_full_app/Widget/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;

  CustomButton({Key? key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50),
        primary: ColorConstants.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text ?? "",
        style: TextStyle(
          color: ColorConstants.white,
          fontSize: 17,
        ),
      ),
    );
  }
}
