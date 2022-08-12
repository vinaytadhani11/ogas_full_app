import 'package:flutter/material.dart';
import 'package:ogas_full_app/Widget/background.dart';
import 'package:ogas_full_app/Widget/colors.dart';
import 'package:ogas_full_app/Widget/drawer_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> scaffoldd = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldd,
      drawer: Drawerpage(),
      body: Background(
        imagename: "asset/icons/Union.png",
          onTap: () {
            scaffoldd.currentState!.openDrawer();
          },
          text: "OGAS",
          child: Column(
            children:[
              Container(
                padding: const EdgeInsets.only(top: 30, left: 25),
                alignment: Alignment.topLeft,
                child: Text(
                  'Recent Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(

                height: MediaQuery.of(context).size.height/1.32,
                child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 10,
                              // itemCount: 5,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (c, i) {
                                return GestureDetector(
                                  onTap: () {
                                    // Get.to(OrderDetails(
                                    //   history: data![i].orderHistory!,
                                    // ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstants.lightGrey,
                                          blurRadius: 1.0,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "# ${i + 1}",
                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "DMSans"),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    " orderDate : ",
                                                    style: TextStyle(fontSize: 12, color: ColorConstants.grey, fontWeight: FontWeight.w600, fontFamily: "DMSans"),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Delivered On",
                                                    style: TextStyle(fontSize: 12, color: ColorConstants.grey, fontWeight: FontWeight.w600, fontFamily: "DMSans"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(top: 30),
                                          height: 35,
                                          // width: 90,
                                          decoration: BoxDecoration(
                                            color: ColorConstants.orange,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              'Order Details',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ColorConstants.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
              ),
          ],
        ),
      ),
    ); 
  }
}