// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_full_app/View/signup.dart';
import 'package:ogas_full_app/prefstring/pref_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawerpage extends StatefulWidget {
  final String? orderId;
  const Drawerpage({Key? key, this.orderId}) : super(key: key);

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  String name = '';
  String? phoneNo;
  getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString(PrefString.name).toString();
    phoneNo = pref.getString(PrefString.phoneNumber);
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(250),
        ),
        child: Drawer(
          elevation: 2,
          // width: 280,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 35,
                  left: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xffF79C2F),
                    foregroundColor: Colors.white,
                    child: Text(name[0].toString().toUpperCase(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "DMSans")),
                  ),
                  title: Text(name.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "DMSans")),
                  subtitle: Text(phoneNo.toString(),
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ),
              ),
              const Divider(
                color: Color(0xffA6A6A6),
              ),
              CustomListTile("asset/icons/drawerList_icon/profile.png", 'Profile', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: ((context) => ProfilePage()),
                //   ),
                // );
              }),
              CustomListTile("asset/icons/drawerList_icon/cart.png", 'OrderHistory', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: ((context) => OrderHistoryPage()),
                //   ),
                // );
              }),
              CustomListTile("asset/icons/drawerList_icon/language.png", 'Language', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: ((context) => LanguagePage()),
                //   ),
                // );
              }),
              CustomListTile("asset/icons/drawerList_icon/complaints.png", 'Complaints', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: ((context) => ComplaintsPage()),
                //   ),
                // );
              }),
              CustomListTile("asset/icons/drawerList_icon/product_detail.png", 'ProductDetails', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: ((context) => ProductDetailPage()),
                //   ),
                // );
              }),
              CustomListTile("asset/icons/drawerList_icon/faq.png", 'Faq', () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: ((context) => FaqPage()),
                //   ),
                // );
              }),
              CustomListTile("asset/icons/drawerList_icon/sign_out.png", 'SignOut', () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(PrefString.loggedIn, "loggedOut");
                await FirebaseAuth.instance.signOut();

                Get.offAll(SignUp(sign: false));
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  String image;
  String text;
  void Function() onTap;

  CustomListTile(this.image, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(
                image,
              ),
              height: 28,
              width: 28,
              alignment: Alignment.topCenter,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "DMSans"),
            ),
          ],
        ),
      ),
    );
  }
}
