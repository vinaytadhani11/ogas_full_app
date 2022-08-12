// ignore_for_file: body_might_complete_normally_nullable

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_full_app/View/otpverification.dart';
import 'package:ogas_full_app/Widget/custom_textfield.dart';
import 'package:ogas_full_app/Widget/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../prefstring/pref_string.dart';

bool login = true;

class SignUp extends StatefulWidget {
  bool sign = true;
  SignUp({Key? key,required this.sign,}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String code = '';
  String countryCodes = '+91';

  signin({
    @required BuildContext? context,
    @required String? phone,
  }) async {
    print(" -=-=-=-= Start signup function =-=-=-=-");
    await SharedPreferences.getInstance();
    bool isSuccess = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      print("-=-=-=-= Start creating user to auth =-=-=-=-");
      await _auth.verifyPhoneNumber(
        phoneNumber: phone!,
        timeout: Duration(seconds: 90),
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) async {
          print("---------------verificationFailed----------------");
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Color(0xffF2F3F2),
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.TOP,
            messageText: Text(
              'phoneNumber Verification Failed please check phoneNumber',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ));
        },
        codeSent: (verificationId, [resendingToken]) async {
            print("----------------codeSent----------------");
            hideLoadingDialog(context: context);

          Navigator.of(context!).push(MaterialPageRoute(builder: (context) => OtpVarification( code: '',varificationId: verificationId,)));
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          print("---------------OTP_TimeOut----------------");
        },
      );
    } catch (e) {
      print("Error --- $e");
    }

    print("End signup function");
    return isSuccess;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height + 50,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFBB941),
                  Color(0xffF58823),
                  Color(0xffF58823),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 190,
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          widget.sign == true ? "Create Your\nAccount" : "Hello\nSign In",
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 190,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(35),
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            // color:Color(0xffF58823),
                            image: DecorationImage(image: AssetImage("asset/icons/create.png"), fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          prefixIcon: SizedBox(
                            height: 20,
                            child: CountryCodePicker(
                              padding: const EdgeInsets.only(bottom: 3),
                              initialSelection: '+91',
                              favorite: ['+91', '+1'],
                              textStyle: TextStyle(color: Colors.orange[900]),
                              showFlag: true,
                              showFlagDialog: true,
                              onChanged: (CountryCode countryCode) async {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                countryCodes = countryCode.toString();
                                pref.setString(PrefString.countryCode, countryCodes);
                  
                                setState(() {});
                                print("New Country selected: " + countryCode.toString());
                              },
                            ),
                          ),
                          controller: _phoneController,
                          hintText: '+968 955 556 98',
                          name: 'PhoneNumber',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please add phone number";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        widget.sign == true
                            ? CustomTextField(
                                controller: _emailController,
                                hintText: 'example@gmail.com',
                                validator: (value) {
                                  if (!value!.contains("@") || !value.contains(".")) {
                                    return "Please enter valid email address";
                                  }
                                  if (value.isEmpty) {
                                    return "Please add email address";
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                              )
                            : const SizedBox(),

                        const SizedBox(height: 45),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            primary: const Color(0xff1C75BC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () async {

                             if (_formKey.currentState!.validate()) {
                              showLoadingDialog(context: context);
                              SharedPreferences pref = await SharedPreferences.getInstance();

                              pref.setString(PrefString.phoneNumber, _phoneController.text);
                              pref.setString(PrefString.email, _emailController.text);
                              
                              if (widget.sign == true) {
                                login = false;
                                
                                setState(() {});
                                signin(context: context, phone: countryCodes + _phoneController.text);
                                
                                } else {
                                  login = true;
                                  setState(() {});
                                  }

                             }
                           },
                          child: const Text(
                            "GET OTP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.sign == true ? "Already have account? ": "Dont have account?",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.sign = !widget.sign;
                                      login = !login;
                                      print(login);
                                    });
                                  },
                                  child: Text(
                                    widget.sign == true ? 'Sign In' : 'Sign Up',
                                    style: const TextStyle(
                                      color: Color(0xff212121),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}