import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp/app/component/no_found.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/model/messge_model.dart';
import 'package:petapp/app/model/notifications_response.dart';

import '../../../services/base_client.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  BaseClient baseClient = BaseClient();
  AnimationController? localAnimationController;
  NotificationsResposeModel? notificationsResposeModel;
  bool isLoading = true;
  bool newnotification = false;
  MessageModel? messageModel;
  int count = 0;

  getNotifications() async {
    isLoading = true;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getNotifications}${BaseClient.box2.read("user_id")}");


        print("===========$response========notification=======");

    notificationsResposeModel = notificationsResposeModelFromJson(response);

    



    isLoading = false;
    setState(() {});
  }

  getNotifications2() async {
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getNotifications}${BaseClient.box2.read("user_id")}");

    notificationsResposeModel = notificationsResposeModelFromJson(response);
    setState(() {
      
    });
  }

  @override
  void initState() {
    getNotifications();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      getNotifications2();
    });
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: AppColor.accentWhite,
        elevation: 0,
        title: Text(
          "Notifications",
          style: Texttheme.heading2,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : notificationsResposeModel!.result!.notifications!.isEmpty
              ? Center(child: SizedBox(
                // height: 50,
                child: noFound("No New Notifications",Icons.notifications))) 
              : Container(
                  // height: 50,
                  width: screenSize.width,
                  child: ListView(
                      children: notificationsResposeModel!
                          .result!.notifications!
                          .map((e) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.accentWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            blurRadius: 20.0, // soften the shadow
                            spreadRadius: 0.0, //extend the shadow
                            offset: Offset(
                              5.0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 20,
                            // width: 57,
                            decoration: BoxDecoration(
                                color: e.seen == false
                                    ? AppColor.lightblue
                                    : AppColor.accentWhite),
                            child: Text(
                              "${e.title}",
                              style:
                                  TextStyle(fontFamily: "Roboto", fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            height: 3.5,
                          ),
                          Text(
                            "${e.description}",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  }).toList())),
    );
  }
}
