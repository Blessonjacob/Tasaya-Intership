import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/constant_method.dart';
import '../services/service.dart';
import 'components/error_container.dart';
import 'login_page.dart';

class NewPassword extends StatefulWidget {
  final String phoneNumber;

  const NewPassword({Key? key, required this.phoneNumber}) : super(key: key);
  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _passwordController = TextEditingController();
  var isLoading = false;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // ignore: unused_local_variable
    final width = MediaQuery.of(context).size.width;
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
                    "Change Password",
                    style: TextStyle(color: theme.primaryColor, fontSize: 30),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 70),
                  if (errorText.isNotEmpty) ErrorContainer(errorText: RxString(errorText)),
                  const SizedBox(height: 20),
                  Text("Enter your new Password", style: theme.textTheme.titleMedium),
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
                                  controller: _passwordController,
                                  keyboardType: TextInputType.phone,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Enter New Password',
                                    hintStyle: TextStyle(color: theme.primaryColorLight),
                                    prefixIcon: Icon(Icons.phone_android_rounded, color: theme.primaryColorLight),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 40,
                            color: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () async {
                              var newpassword = _passwordController.text;

                              if (newpassword.length >= 4) {
                                try {
                                  var response = await Services().changepassword(widget.phoneNumber, newpassword);
                                  if (response!.status == true) {
                                    successMsg(response.message!, true);
                                    Get.offAll(() => LoginPage());
                                    isLoading = false;
                                  }
                                } on Exception catch (e) {
                                  throw Exception('Ex : $e');
                                }
                              } else if (_passwordController.text.isEmpty) {
                                setState(() {
                                  errorText = "Plaese enter your Password";
                                });
                              } else {
                                setState(() {
                                  errorText = "Plaese enter Correct Password";
                                });
                              }
                            },
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text("Confirm", style: theme.textTheme.titleMedium!.copyWith(color: Colors.white)),
                          ),
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
}
