import 'package:flutter/material.dart';
import 'package:muroexe_store/src/core/constants/app_color.dart';

void showSnackBar(BuildContext? context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 1200),
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
    ),
    backgroundColor: Muroexe.mainColor.withOpacity(0.8), // Colors.blueGrey,
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Muroexe.textColor,
      ),
    ),
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}
