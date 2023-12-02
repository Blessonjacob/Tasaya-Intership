import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasaya_partner_application/main.dart';
import '../services/service.dart';
import 'ApiService.dart';
import 'forgot_password.dart';
import '../controllers/grocery_controller.dart';
import 'components/error_container.dart';
import 'phone_number.dart';
import 'register_page.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isObsecure = true.obs;
  RxString errorText = "".obs;
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

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
                // SizedBox(height: height / 6),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/images/tasaya1.png",
                    // height: 250,
                  ),
                ),

                Obx(
                  () => errorText.value.isNotEmpty ? ErrorContainer(errorText: errorText) : const SizedBox(height: 32),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Material(
                          elevation: 1,
                          color: theme.primaryColorDark,
                          shadowColor: theme.shadowColor,
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                style: theme.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your phone number";
                                  }
                                  return null;
                                },
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
                        Material(
                          elevation: 1,
                          color: theme.primaryColorDark,
                          shadowColor: theme.shadowColor,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  return null;
                                },
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: 'Enter Password',
                                  hintStyle: TextStyle(color: theme.primaryColorLight),
                                  border: InputBorder.none,
                                  errorStyle: const TextStyle(),
                                  errorText: null,
                                  prefixIcon: Icon(Icons.password_rounded, color: theme.primaryColorLight),
                                  suffixIcon: IconButton(
                                    icon: Icon(isObsecure.value ? Icons.visibility_off : Icons.visibility, color: theme.primaryColorLight),
                                    onPressed: () {
                                      isObsecure.value = !isObsecure.value;
                                    },
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(() => ForgotPassword());
                              },
                              child: const Text(
                                "Forgot Password?",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        MaterialButton(
                            minWidth: width,
                            height: 40,
                            animationDuration: const Duration(seconds: 1),
                            color: theme.primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            disabledColor: theme.primaryColor,
                            onPressed: isLoading.value
                                ? null
                                : () async {
                                    bool isValidate = false;

                                    isValidate = _phoneNumberValidator(_phoneNumberController.text) == 0 && _validatePassrword(_passwordController.text) == 0;

                                    if (isValidate) {
                                      isLoading.value = true;
                                      var response = await Services().login(_phoneNumberController.text, _passwordController.text);
                                      if (response!.status == true) {
                                        var prefs = await SharedPreferences.getInstance();
                                        prefs.setBool('isLogIn', true);
                                        prefs.setString('customer_id', response.data!.customerId.toString());
                                        prefs.setString('userName', response.data!.customerName.toString());
                                        prefs.setString('userEmail', response.data!.customerEmail.toString());
                                        prefs.setString('userNumber', response.data!.customerMobile.toString());
                                          Get.off(() => RegisterPage());
                                        GroceryController().onLoad();
                                        isLoading.value = false;
                                        errorText.value = "";
                                      } else {
                                        errorText.value = "${response.message}";
                                        isLoading.value = false;
                                        HapticFeedback.lightImpact();
                                      }
                                    } else {
                                      HapticFeedback.lightImpact();
                                      errorText.value = "Please enter Correct Credentails";
                                    }
                                  },
                            child: Obx(
                              () => isLoading.value
                                  ? Center(
                                      child: Lottie.asset(
                                      'assets/animations/login_loading.json',
                                      repeat: true,
                                      animate: true,
                                      width: 50,
                                      height: 40,
                                    ))
                                  : Text("SIGN IN", style: theme.textTheme.titleMedium!.copyWith(color: Colors.white)),
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // const Text("Or"),
                Divider(color: theme.primaryColorLight),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      child: ElevatedButton(
                        clipBehavior: Clip.antiAlias,
                        onPressed: () async {
                          final GoogleSignIn googleSignIn = GoogleSignIn();
                          googleSignIn.signIn().then((result) {
                            result!.authentication.then((googleKey) async {
                              var response = await Services().googleLogin(
                                "",
                                googleSignIn.currentUser!.displayName!,
                                googleSignIn.currentUser!.email,
                                googleKey.accessToken!,
                                googleSignIn.currentUser!.photoUrl!,
                              );
                              if (response!.status == true && response.data!.customerTempMobile!.isNotEmpty) {
                                var prefs = await SharedPreferences.getInstance();

                                prefs.setBool('isLogIn', true);
                                prefs.setString('customer_id', response.data!.customerId.toString());
                                prefs.setString('userName', response.data!.customerName.toString());
                                prefs.setString('userEmail', response.data!.customerEmail.toString());
                                prefs.setString('userNumber', response.data!.customerTempMobile.toString());
                                prefs.setString('image', response.data!.image!);
                                Get.offAll(() => MyHomePage());

                                errorText.value = "";
                              } else if (response.data!.customerTempMobile!.isEmpty) {
                                Get.to(
                                  () => PhoneNumber(
                                    accessToken: googleKey.accessToken!,
                                    displayName: googleSignIn.currentUser!.displayName!,
                                    email: googleSignIn.currentUser!.email,
                                    imageUrl: googleSignIn.currentUser!.photoUrl!,
                                    uid: response.data!.customerId!,
                                  ),
                                );
                              } else {
                                errorText.value = "${response.message}";
                                isLoading.value = false;
                              }
                            }).catchError((err) {
                              errorText.value = err.toString();
                            });
                          }).catchError((err) {
                            errorText.value = err.toString();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Continue with Google",
                              style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have Account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() =>RegisterPage());
                      },
                      child: const Text(
                        "Register",
                      ),
                    ),
                  ],
                ),
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
  // Example in your login page
  void handleForgotPassword() async {
    var mobile = '7440498598'; // Replace with the actual mobile number
    var response = await ApiService().forgotPassword(mobile);

    // Handle the response here
    print(response);
  }
}
