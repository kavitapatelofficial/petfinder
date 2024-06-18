import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/model/notifications_response.dart';
import 'package:petapp/app/modules/notification/notifications_screen.dart';
import 'package:petapp/main.dart';

import '../../../services/base_client.dart';
import '../../constent/api_urls.dart';
import '../../routes/app_pages.dart';
import '../buttons/defaultbutton.dart';
import 'package:timezone/timezone.dart' as tz;

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  BaseClient baseClient = BaseClient();
  AnimationController? localAnimationController;
  NotificationsResposeModel? notificationsResposeModel;
  bool isLoading = true;
  bool newnotification = false;
  int count = 0;

  getNotifications() async {
    isLoading = true;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getNotifications}${BaseClient.box2.read("user_id")}");

    notificationsResposeModel = notificationsResposeModelFromJson(response);

    if (notificationsResposeModel!.result!.count != 0) {
      count = notificationsResposeModel!.result!.count == null
          ? 0
          : notificationsResposeModel!.result!.count!;
      showNotification(
          notificationsResposeModel!.result!.notifications!.first.title ==
                  null
              ? ""
              : notificationsResposeModel!
                  .result!.notifications!.first.title!,
          notificationsResposeModel!
                      .result!.notifications!.first.description ==
                  null
              ? ""
              : notificationsResposeModel!
                  .result!.notifications!.first.description!
                  .toString());
    }

    isLoading = false;
    setState(() {});
  }

  getNotifications2() async {
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getNotifications}${BaseClient.box2.read("user_id")}");

    notificationsResposeModel = notificationsResposeModelFromJson(response);
    if (notificationsResposeModel!.result!.count != 0) {
      count = notificationsResposeModel!.result!.count == null
          ? 0
          : notificationsResposeModel!.result!.count!;

      newnotification = true;

      showNotification(
          notificationsResposeModel!.result!.notifications!.first.title ==
                  null
              ? ""
              : notificationsResposeModel!
                  .result!.notifications!.first.title!,
          notificationsResposeModel!
                      .result!.notifications!.first.description ==
                  null
              ? ""
              : notificationsResposeModel!
                  .result!.notifications!.first.description!
                  .toString());
    }

    setState(() {});
  }

  void showNotification(String title, String desc) async {
    // ignore: prefer_const_constructors
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "notifications-youtube", "YouTube Notifications",
        priority: Priority.max, importance: Importance.max);

    // ignore: prefer_const_constructors
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    DateTime scheduleDate = DateTime.now().add(const Duration(seconds: 1));

    await notificationsPlugin.zonedSchedule(0, "$title", "$desc",
        tz.TZDateTime.from(scheduleDate, tz.local), notiDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: "$title");

    Future selectNotification(String payload) async {
      // _showGuidePopup(context);
      //Handle notification tapped logic here
    }
  }

  void checkForNotification() async {
    NotificationAppLaunchDetails? details =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if (response != null) {
          String? payload = response.payload;
        }
      }
    }
  }

  @override
  void initState() {
    getNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () {
      newnotification == false ? getNotifications2() : null;
      // setState(() {});
    });
    return AppBar(
      elevation: 1,
      iconTheme: IconThemeData(color: AppColor.defaultBlackColor),
      title: Text(
        widget.title,
        style: Texttheme.subheading.copyWith(color: Colors.black),
      ),
      backgroundColor: AppColor.accentWhite,
      automaticallyImplyLeading: true,
      actions: [
        isLoading
            ? SizedBox()
            : count == 0
                ? IconButton(
                    onPressed: () {
                      var data = {};
                      final apiResponse = baseClient.put(
                        false,
                        ConstantsUrls.baseURL,
                        "/api/seenNotification/${BaseClient.box2.read("user_id")}",
                        data,
                      );
                      setState(() {
                        count = 0;
                        newnotification = false;
                      });

                      Get.to(NotificationsScreen());
                    },
                    icon: const Icon(
                      Icons.notifications,
                      size: 30,
                    ))
                : Badge(
                    position: BadgePosition.topEnd(top: 0, end: 0),
                    badgeContent: Text(
                      '${notificationsResposeModel!.result!.count}',
                      style: TextStyle(color: AppColor.accentWhite),
                    ),
                    child: IconButton(
                        onPressed: () {
                          var data = {};
                          final apiResponse = baseClient.put(
                            false,
                            ConstantsUrls.baseURL,
                            "/api/seenNotification/${BaseClient.box2.read("user_id")}",
                            data,
                          );
                          setState(() {
                            count = 0;
                            newnotification = false;
                          });

                          Get.to(NotificationsScreen());
                        },
                        icon: Icon(
                          Icons.notifications,
                          size: 30,
                        )),
                  ),
        IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.more_vert))
      ],
     
          
    );
  }

  void _logout(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Wrap(
              children: <Widget>[
                const SizedBox(height: 20),
                Center(
                    child: Icon(
                  Icons.logout,
                  color: AppColor.neturalRed,
                  size: 100,
                )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 53),
                    child: RoundedButton(
                      text: "Logout",
                      press: () {
                        var box2 = GetStorage();
                        box2.erase();
                        Get.offNamedUntil(AppPages.INITIAL, (route) => false);
                      },
                    )),
                const SizedBox(
                  height: 73,
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showGuidePopup(context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: screenSize.height * 0.8,
            width: screenSize.width,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 0),
            child: Stack(
              children: [
                Positioned(
                  left: 0, // left coordinate
                  top: 10,
                  right: 0,
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: AppColor.lightblue),
                      ),
                      scrollable: true,
                      content: isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : notificationsResposeModel!
                                  .result!.notifications!.isEmpty
                              ? Container(
                                  height: 50,
                                  width: screenSize.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${notificationsResposeModel!.message == null ? "" : notificationsResposeModel!.message}",
                                        style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  // height: 50,
                                  width: screenSize.width,
                                  child: ListView(
                                      children: notificationsResposeModel!
                                          .result!.notifications!
                                          .map((e) {
                                    return Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            height: 20,
                                            // width: 57,
                                            decoration: BoxDecoration(
                                                color: AppColor.lightblue),
                                            child: Text(
                                              "${e.title}",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 10),
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
                                          Divider()
                                        ],
                                      ),
                                    );
                                  }).toList()))),
                ),
              ],
            ),
          );
        });
  }

  _showGuidePopup2(context, String title, String desc) {
    var screenSize = MediaQuery.maybeOf(context)!.size;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: screenSize.width,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 500),
            child: AlertDialog(
              content: Container(
                height: 50,
                width: screenSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 15,
                      width: 57,
                      decoration: BoxDecoration(color: AppColor.lightblue),
                      child: Center(
                          child: Text(
                        "$title",
                        style: TextStyle(fontFamily: "Roboto", fontSize: 10),
                      )),
                    ),
                    SizedBox(
                      height: 3.5,
                    ),
                    Text(
                      "$desc",
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
