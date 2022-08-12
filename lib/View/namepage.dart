import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_full_app/View/home_page.dart';
import 'package:ogas_full_app/Widget/colors.dart';
import 'package:ogas_full_app/Widget/coustm_button.dart';
import 'package:ogas_full_app/Widget/loading_dialog.dart';
import 'package:ogas_full_app/prefstring/pref_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NamePage extends StatefulWidget {
  NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController _nameController = TextEditingController();
  String? phoneNumber;
  String? name;
  getPhoneNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    phoneNumber = pref.getString(PrefString.phoneNumber);

    setState(() {});
    print("++++++++++++++++++++++++++++++");

    print(phoneNumber);
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
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'What\'s your \nname',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontFamily: "DMSans"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 190,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(50),
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("asset/icons/full name.png"), fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text('Full name',
                          style: TextStyle(
                            color: Color(0xff212121),
                            fontSize: 16,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontFamily: "DMSans",
                          ),
                          hintText: 'john',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorConstants.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      text: 'Enter',
                      onPressed: () async {
                        showLoadingDialog(context: context);

                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setString(PrefString.name, _nameController.text);
                        pref.setString(PrefString.loggedIn, 'loggedIn');
                            setState(() {});

                        Get.offAll(HomePage());
                        
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}