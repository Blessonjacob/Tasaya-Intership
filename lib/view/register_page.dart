import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasaya_partner_application/main.dart';
import '../services/service.dart';
import '../constants/constant_method.dart';
import '../controllers/controller.dart';
import 'ApiService.dart';
import 'components/error_container.dart';

import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  // RegisterPage({super.key});

  MyController controller = Get.put( MyController());

  RxBool isLoading = false.obs;
  RxBool isObsecure = true.obs;
  RxBool isverify = false.obs;
  RxBool isVerified = false.obs;
  RxString errorText = "".obs;

  final _phoneNumberController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/tasaya1.png", height: 200),
                Obx(
                  () => errorText.value.isNotEmpty ? ErrorContainer(errorText: errorText) : const SizedBox(height: 32),
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
                                controller: _userNameController,
                                keyboardType: TextInputType.name,
                                style: theme.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: 'Enter User Name',
                                  hintStyle: TextStyle(color: theme.primaryColorLight),
                                  prefixIcon: Icon(Icons.person, color: theme.primaryColorLight),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                                    suffix: Obx(
                                      () => isVerified.value
                                          ? const Padding(
                                              padding: EdgeInsets.only(right: 10),
                                              child: Text(
                                                'verified',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () async {
                                                var number = _phoneNumberController.text;
                                                bool isValidate = false;
                                                isValidate = _phoneNumberValidator(number) == 0;
                                                if (isValidate) {
                                                  try {
                                                    var response = await Services().forgotPassword(number);
                                                    if (response!.status == true) {
                                                      successMsg(response.message!, true);
                                                      isverify.value = true;
                                                      errorText.value = "";
                                                    }
                                                  } on Exception catch (e) {
                                                    Get.defaultDialog(content: Text('$e'));
                                                  }
                                                } else if (_phoneNumberController.text.isEmpty) {
                                                  errorText.value = "Plaese enter your phone Number";
                                                } else {
                                                  errorText.value = "Plaese enter Correct phone Number";
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: Text(
                                                  'Get OTP',
                                                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13),
                                                ),
                                              )),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Obx(() => isverify.value ? const SizedBox(height: 10) : const SizedBox()),
                        Obx(
                          () => isverify.value
                              ? Material(
                                  elevation: 1,
                                  shadowColor: theme.shadowColor,
                                  color: theme.primaryColorDark,
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: TextFormField(
                                        controller: _otpController,
                                        keyboardType: TextInputType.phone,
                                        style: theme.textTheme.titleSmall!.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                        ),
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          hintText: 'Enter OTP',
                                          hintStyle: TextStyle(color: theme.primaryColorLight),
                                          prefixIcon: Icon(Icons.phone_android_rounded, color: theme.primaryColorLight),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          elevation: 1,
                          shadowColor: theme.shadowColor,
                          color: theme.primaryColorDark,
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: theme.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: 'Enter Email Address',
                                  hintStyle: TextStyle(color: theme.primaryColorLight),
                                  prefixIcon: Icon(Icons.email_rounded, color: theme.primaryColorLight),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          elevation: 1,
                          shadowColor: theme.shadowColor,
                          color: theme.primaryColorDark,
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Obx(
                                () => TextFormField(
                                  obscureText: isObsecure.value,
                                  obscuringCharacter: '*',
                                  controller: _passwordController,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(color: theme.primaryColorLight),
                                    border: InputBorder.none,
                                    errorStyle: const TextStyle(),
                                    errorText: null,
                                    prefixIcon: Icon(Icons.password_rounded, color: theme.primaryColorLight),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                        color: theme.primaryColorLight,
                                      ),
                                      onPressed: () {
                                        isObsecure.value = !isObsecure.value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                            minWidth: width,
                            height: 40,
                            animationDuration: const Duration(seconds: 1),
                            color: theme.primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            disabledColor: theme.primaryColor,
                            onPressed: () async {
                              var otp = _otpController.text;
                              if (otp.length == 4) {
                                var response = await Services().otpVerify(_phoneNumberController.text, otp);
                                if (response!.status == true) {
                                  Get.rawSnackbar(message: '${response.message}');

                                  isverify.value = false;
                                  isVerified.value = true;
                                } else {
                                  errorText.value = '${response.message}';
                                }
                              } else {
                                errorText.value = 'Enter Correct OTP';
                              }
                              bool isValidate = false;

                              isValidate = _phoneNumberValidator(_phoneNumberController.text) == 0 && _validatePassrword(_passwordController.text) == 0 && _emailController.text.isEmail;

                              if (isValidate) {
                                var response = await Services().registration(_userNameController.text, _emailController.text, _phoneNumberController.text, _passwordController.text);
                                if (response!.status == true) {
                                  controller.phoneNumber.value = _phoneNumberController.text;
                                  controller.useName.value = _userNameController.text;
                                  controller.emailAddress.value = _emailController.text;
                                  controller.uid.value = response.uid.toString();

                                  Get.offAll(MyHomePage());
                                  controller.isLoggedIn.value = true;
                                  errorText.value = "";
                                  _passwordController.text = "";
                                  _emailController.text = "";
                                  _userNameController.text = "";
                                  _phoneNumberController.text = "";
                                } else {
                                  errorText.value = response.message.toString();
                                }
                                if (isVerified.value) {
                                } else {
                                  errorText.value = "Please verify your Number first!";
                                }
                              } else {
                                errorText.value = "Plaese enter Correct Information";
                              }
                            },
                            child: Obx(() => isLoading.value
                                ? CircularProgressIndicator(
                                    color: theme.primaryColor,
                                  )
                                : Text("SIGN UP", style: theme.textTheme.titleMedium!.copyWith(color: Colors.white)))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => MyHomePage());
                      },
                      child: const Text(
                        "Sign In",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _validatePassrword(String? value) {
    if (value!.isEmpty) {
      return 1;
    }
    return 0;
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


// Example in your registration page
  void handleRegistration() async {
    var name = 'pawan patil';
    var email = 'pawanpatil405@gmail.com';
    var mobile = '8770034434';
    var city = 'khadava';
    var password = '123';

    var response = await ApiService().register(name, email, mobile, city, password);

    // Handle the response here
    print(response);
  }

}
