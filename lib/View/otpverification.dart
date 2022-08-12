import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_full_app/View/home_page.dart';
import 'package:ogas_full_app/View/namepage.dart';
import 'package:ogas_full_app/View/signup.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ogas_full_app/Widget/colors.dart';
import 'package:ogas_full_app/Widget/coustm_button.dart';
import 'package:ogas_full_app/Widget/loading_dialog.dart';

import '../prefstring/pref_string.dart';

class OtpVarification extends StatefulWidget {
  final String code;
  final String? varificationId;
  OtpVarification({
    Key? key,
    required this.code,
    this.varificationId,
  }) : super(key: key);

  @override
  State<OtpVarification> createState() => _OtpVarificationState();
}

class _OtpVarificationState extends State<OtpVarification> {
  OtpFieldController controller = OtpFieldController();
  String? phone;
  String? countryCode;
  String? pincode;
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 90;
  int currentSeconds = 0;
  Timer? timerData;
  String get timerText => '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')} : ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  
  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      timerData = timer;
      if (mounted) {
        setState(() {
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) timer.cancel();
        });
      }
    });
  }

  getphone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    phone = pref.getString(PrefString.phoneNumber);
    countryCode = pref.getString(PrefString.countryCode);
    setState(() {});
    print(phone);
    print(countryCode);
  }
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getphone();
    startTimeout();
    print('=================${widget.code}');
    super.initState();
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(PrefString.loggedIn, 'loggedIn');
        hideLoadingDialog(context: context);

        login == true ? Get.to(HomePage()) : Get.to(NamePage());

        Get.showSnackbar(const GetSnackBar(
          backgroundColor: ColorConstants.snackbarColor,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.TOP,
          messageText: Text(
            'Successfully Verified',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ));
      }
    } on FirebaseAuthException {
      showMessage('Invalid Otp');
    }
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstants.lightOrange,
                ColorConstants.orange,
                ColorConstants.orange,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/gascylinderback.png"),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: const Text(
                        'Otp varification',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontFamily: "DMSans"),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 35,
                            right: 35,
                            top: 20,
                          ),
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage("asset/icons/otp.png"), fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          alignment: Alignment.topCenter,
                          child: const Text('We have sent the code verification to your mobile number',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ColorConstants.grey,
                                fontSize: 16,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 13),
                          alignment: Alignment.topCenter,
                          child: Text(phone.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ColorConstants.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        OTPTextField(
                          length: 6,
                          controller: controller,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 50,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          otpFieldStyle: OtpFieldStyle(
                            enabledBorderColor: ColorConstants.grey,
                            focusBorderColor: ColorConstants.black,
                            borderColor: ColorConstants.grey,
                          ),
                          onCompleted: (pin) {
                            pincode = pin;
                            setState(() {});
                            print("Completed: " + pincode.toString());
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          onPressed: () async {
                            showLoadingDialog(context: context);

                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setString(PrefString.phoneNumber, phone.toString());
                            setState(() {
                              print(phone);
                            });
                            
                            PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: widget.varificationId!, smsCode: pincode.toString());

                            signInWithPhoneAuthCredential(phoneAuthCredential);
                            
                            hideLoadingDialog(context: context);
                          },
                          text: 'Submit',
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            timerText,
                            style: TextStyle(
                              color: timerText == "00 : 00" ? ColorConstants.grey : ColorConstants.orange,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Dont recieve otp?',
                                  style: const TextStyle(
                                    color: ColorConstants.grey,
                                    fontSize: 15,
                                    fontFamily: "DMSans",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (timerText == "00 : 00") {
                                      timerData?.cancel();
                                      // startTimeout();
                                      // resend(context: context, phone: "+1$phone");
                                    }
                                  },
                                  child: Text(
                                    ' Resend otp',
                                    style: TextStyle(
                                      color: ColorConstants.black.withOpacity(timerText == "00 : 00" ? 1 : 0.5),
                                      fontSize: 15,
                                      fontFamily: "DMSans",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}