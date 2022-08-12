import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_full_app/Utils/utili.dart';
import 'package:ogas_full_app/View/home_page.dart';
import 'package:ogas_full_app/View/signup.dart';
import 'package:ogas_full_app/prefstring/pref_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpleshScreen extends StatefulWidget {
  SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  String? status;
  
  @override
  void initState() {
    _navigateHome();
    super.initState();
  }

  _navigateHome(){
    Timer(Duration(milliseconds: 3),()async{
      SharedPreferences pref = await SharedPreferences.getInstance();
      status = pref.getString(PrefString.loggedIn);

      print('status-----$status');

      if(status == 'loggedIn'){
        Get.offAll(HomePage());
      }else{
        Get.offAll(() => SignUp(sign: false),);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("asset/splash.png",),fit: BoxFit.cover),
        ),
      ),
    );
  }
}