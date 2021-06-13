import 'package:flutter/material.dart';
import 'package:task/theme.dart';

buildSnackBar({BuildContext? context, String? message, bool isError = false}) {
  return ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(message!),
    duration: const Duration(seconds: 3),
    backgroundColor: isError ? Colors.red : MyColors.primaryColor,
  ));
}