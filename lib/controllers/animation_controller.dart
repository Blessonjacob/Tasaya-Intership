import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyAnimationController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController lottieController;

  @override
  void onInit() {
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Get.back();
        lottieController.reset();
      }
    });
    super.onInit();
  }

  void showSuccesDailog(String message) {
    Get.defaultDialog(
      title: "Success",
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Lottie.asset(
          "assets/animations/order_confirmed.json",
          repeat: false,
          height: 200,
          width: 200,
          controller: lottieController,
          onLoaded: (composition) {
            lottieController.duration = composition.duration;
            lottieController.forward();
          },
        ),
        Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 21),
      ]),
    );
  }
}
