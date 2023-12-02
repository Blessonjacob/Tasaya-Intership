import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successMsg(String message, bool isSuccess) {
  Get.rawSnackbar(
      messageText: Text(message, style: Get.textTheme.titleSmall!.copyWith(color: Colors.white)),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
      icon: Icon(isSuccess ? Icons.check_circle_outline : Icons.error_outline_rounded, color: Colors.white),
      shouldIconPulse: true,
      maxWidth: 500,
      overlayBlur: 0,
      overlayColor: Colors.black.withOpacity(0.2),
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'OK',
          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
      ));
}
