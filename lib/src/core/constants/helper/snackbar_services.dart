import 'package:flutter/material.dart';
import 'package:muroexe_store/src/core/constants/app_color.dart';

class SnackServices {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
      String text) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        backgroundColor: Muroexe.mainColor.withOpacity(0.8),
      ),
    );
  }
}
