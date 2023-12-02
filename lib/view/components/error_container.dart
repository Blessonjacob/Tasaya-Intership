import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  final RxString errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            errorText.value,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
          GestureDetector(onTap: () => errorText.value = "", child: Image.asset('assets/icons/cross.png', color: Colors.red, width: 14))
        ],
      ),
    );
  }
}
