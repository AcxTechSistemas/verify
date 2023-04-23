import 'package:flutter/material.dart';

enum SnackBarType {
  error(backgroundColor: Color(0xffBA0900), textColor: Colors.white),
  alert(backgroundColor: Color(0xffE14400), textColor: Colors.white),
  info(backgroundColor: Color(0xff0801E1), textColor: Colors.white),
  success(backgroundColor: Color(0xff006600), textColor: Colors.white);

  const SnackBarType({required this.backgroundColor, required this.textColor});

  final Color backgroundColor;
  final Color textColor;
}

class CustomSnackBar extends SnackBar {
  final String message;
  final SnackBarType snackBarType;

  CustomSnackBar({
    super.key,
    required this.message,
    required this.snackBarType,
  }) : super(
          behavior: SnackBarBehavior.floating,
          content: Semantics(
            label: message,
            child: Text(
              message,
              style: const TextStyle().copyWith(
                color: snackBarType.textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: snackBarType.backgroundColor,
        );
}
