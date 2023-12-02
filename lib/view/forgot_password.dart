import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/service.dart';


import 'components/error_container.dart';
import 'opt_verify.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final _phoneNumberController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorText = "".obs;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height / 13),
                  Text(
                    "Forgot Password",
                    style: TextStyle(color: theme.primaryColor, fontSize: 30),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 70),
                  Obx(
                    () => errorText.value.isNotEmpty ? ErrorContainer(errorText: errorText) : const SizedBox(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Text("Enter your Phone Number to retrieve your Password", style: theme.textTheme.titleSmall),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: [
                          Material(
                            elevation: 1,
                            shadowColor: theme.shadowColor,
                            color: theme.primaryColorDark,
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: TextFormField(
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Number',
                                    hintStyle: TextStyle(color: theme.primaryColorLight),
                                    prefixIcon: Icon(Icons.phone_android_rounded, color: theme.primaryColorLight),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                              minWidth: double.infinity,
                              height: 40,
                              animationDuration: const Duration(seconds: 1),
                              color: theme.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              disabledColor: theme.primaryColor,
                              onPressed: () async {
                                var number = _phoneNumberController.text;
                                bool isValidate = false;

                                isValidate = _phoneNumberValidator(number) == 0;

                                if (isValidate) {
                                  try {
                                    var response = await Services().forgotPassword(number);
                                    if (response!.status == true) {
                                      Get.to(() => OptVerification(phoneNumber: number));
                                      errorText.value = "";

                                      isLoading.value = false;
                                    } else {
                                      errorText.value = response.message!;
                                    }
                                  } on Exception catch (e) {
                                    throw Exception('Ex : $e');
                                  }
                                } else if (_phoneNumberController.text.isEmpty) {
                                  errorText.value = "Plaese enter your phone Number";
                                } else {
                                  errorText.value = "Plaese enter Correct phone Number";
                                }
                              },
                              child: Obx(
                                () => isLoading.value
                                    ? CircularProgressIndicator(color: theme.primaryColor)
                                    : Text(
                                        "Verify",
                                        style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _phoneNumberValidator(String? value) {
    final regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    if (value!.isEmpty) {
      return 1;
    } else if (!regex.hasMatch(value)) {
      return 1;
    }
    return 0;
  }
}
