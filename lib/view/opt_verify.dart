import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../services/service.dart';
import 'new_password.dart';

class OptVerification extends StatefulWidget {
  final String phoneNumber;
  const OptVerification({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OptVerification> createState() => _OptVerificationState();
}

class _OptVerificationState extends State<OptVerification> {
  String otp = "";
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          foregroundColor: Theme.of(context).primaryColorLight,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColorLight,
            ),
            onPressed: (() => Get.back()),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Verification Code", style: theme.textTheme.titleLarge),
              const SizedBox(height: 10),
              Text("We have sent the code verification to", style: theme.textTheme.titleSmall),
              // const SizedBox(height: 10),
              Row(
                children: [
                  Text("* * * * * * ${widget.phoneNumber.toString().substring(6, 10)}", style: theme.textTheme.bodySmall),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Change phone number ?")),
                ],
              ),
              const SizedBox(height: 15),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            otp += value;
                          }
                        }),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: theme.primaryColorLight),
                          border: const OutlineInputBorder(),
                          enabledBorder: null,
                        ),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            otp += value;
                          }
                        }),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: theme.primaryColorLight),
                          border: const OutlineInputBorder(),
                          enabledBorder: null,
                        ),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            otp += value;
                          }
                        }),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: theme.primaryColorLight),
                          border: const OutlineInputBorder(),
                          enabledBorder: null,
                        ),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            setState(() {
                              otp += value;
                            });
                          }
                        }),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: theme.primaryColorLight),
                          border: const OutlineInputBorder(),
                          enabledBorder: null,
                        ),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    color: theme.primaryColor,
                    textColor: theme.primaryColorLight,
                    height: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      if (otp.length == 4) {
                        var response = await Services().otpVerify(widget.phoneNumber, otp.toString());
                        if (response!.status == true) {
                          Get.to(() => NewPassword(
                                phoneNumber: widget.phoneNumber,
                              ));
                        } else {}
                      } else {}
                    },
                    child: Text("Continue", style: theme.textTheme.titleMedium!.copyWith(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
