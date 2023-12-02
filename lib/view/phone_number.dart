import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasaya_partner_application/main.dart';
import 'package:tasaya_partner_application/view/login_page.dart';
import '../constants/constant_method.dart';
import 'components/two_text.dart';

import '../services/service.dart';


// ignore: must_be_immutable
class PhoneNumber extends StatefulWidget {
  String accessToken;
  String displayName;
  String email;
  String imageUrl;
  String uid;
  PhoneNumber({
    super.key,
    required this.accessToken,
    required this.displayName,
    required this.email,
    required this.imageUrl,
    required this.uid,
  });

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  bool isLoading = false;
  bool isObsecure = true;
  bool isverify = false;
  bool isVerified = false;
  String errorText = "";

  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(50), child: Image.network(widget.imageUrl)),
              const SizedBox(height: 20),
              TwoText(firstText: 'Welcome,', secondText: widget.displayName),
              const SizedBox(height: 20),
              if (errorText.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              const SizedBox(height: 10),
              Material(
                elevation: 3,
                color: theme.primaryColorDark,
                shadowColor: theme.shadowColor,
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 55,
                  child: Center(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
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
              const SizedBox(height: 10),
              if (isverify)
                Material(
                  elevation: 3,
                  color: theme.primaryColorDark,
                  shadowColor: theme.shadowColor,
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
                ),
              const SizedBox(height: 20),
              MaterialButton(
                minWidth: double.infinity,
                height: 40,
                color: theme.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: () async {
                  if (!isVerified && !isverify) await sendOtp(context);
                  if (_otpController.text.isNotEmpty) if (mounted) await verifyOtp(context);
                  if (isVerified) await gotoNextPage();
                },
                child: Text(
                    isVerified
                        ? "Confirm"
                        : isverify
                            ? 'Verfiy Otp'
                            : 'Get Otp',
                    style: theme.textTheme.titleMedium!.copyWith(color: Colors.white)),
              ),
              if (isverify)
                TextButton(
                    onPressed: () async {
                      if (_phoneNumberController.text.isNotEmpty) {
                        await sendOtp(context);
                      }
                    },
                    child: const Text('Send Otp again'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> gotoNextPage() async {
    bool isValidate = false;
    setState(() {
      isValidate = _phoneNumberValidator(_phoneNumberController.text) == 0;
    });
    if (isValidate) {
      if (isVerified) {
        isLoading = true;
        var response = await Services().googleLogin(
          _phoneNumberController.text,
          widget.displayName,
          widget.email,
          widget.accessToken,
          widget.imageUrl,
        );
        if (response!.status == true) {
          var prefs = await SharedPreferences.getInstance();

          prefs.setBool('isLogIn', true);
          prefs.setString('customer_id', response.data!.customerId.toString());
          prefs.setString('userName', response.data!.customerName.toString());
          prefs.setString('userEmail', response.data!.customerEmail.toString());
          prefs.setString('userNumber', response.data!.customerMobile.toString());
          prefs.setString('image', response.data!.image!);

          Get.offAll(() => MyHomePage());
          setState(() {});
          errorText = "";
        } else {
          setState(() {
            errorText = "${response.message}";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorText = 'Please Verifiy your Number first';
        });
      }
    } else {
      setState(() {
        errorText = "Plaese enter Correct Phone Number";
      });
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    var otp = _otpController.text;
    if (otp.length == 4) {
      var response = await Services().otpVerify(_phoneNumberController.text, otp);
      if (response!.status == true) {
        var snackBar = SnackBar(content: Text('${response.message}'));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isverify = false;
          isVerified = true;
        });
      } else {
        setState(() {
          errorText = response.message!;
        });
      }
    } else {
      setState(() {
        errorText = 'Enter Correct Opt';
      });
    }
  }

  Future<void> sendOtp(BuildContext context) async {
    var number = _phoneNumberController.text;
    int uid = int.parse(widget.uid);
    bool isValidate = false;
    setState(() {
      isValidate = _phoneNumberValidator(number) == 0;
    });
    if (isValidate) {
      try {
        var response = await Services().otpSend(number, uid);
        if (response == null) {
          errorText = "Something went wrong";
        } else if (response.status == true) {
          successMsg('${response.message}', true);
          setState(() {
            isverify = true;
          });
          errorText = "";
        } else {
          successMsg("${response.message}", true);
        }
      } on Exception catch (e) {
        throw Exception('Ex : $e');
      }
    } else if (_phoneNumberController.text.isEmpty) {
      setState(() {
        errorText = "Plaese enter your phone Number";
      });
    } else {
      setState(() {
        errorText = "Plaese enter Correct phone Number";
      });
    }
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
