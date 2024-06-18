import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:petapp/app/common_api.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/modules/home/views/home_view.dart';
import 'package:petapp/app/modules/network/bindings/network_binding.dart';
import 'package:petapp/app/modules/network/controllers/network_controller.dart';
import 'package:petapp/app/modules/notification/notifications_screen.dart';

import 'app/routes/app_pages.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest_10y.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterDownloader.initialize();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColor.accentDarkGrey, // navigation bar color
      statusBarColor: Color(0xffF1F1F1), // status bar color
    ),
  );
  await GetStorage.init();

  // Plugin must be initialized before using
  initializeTimeZones();

  AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true);

  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings, iOS: iosSettings);

  bool? initialized = await notificationsPlugin.initialize(
      initializationSettings, onDidReceiveNotificationResponse: (response) {
    print(response.payload.toString());
  });

  print("Notifications: $initialized");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var box = GetStorage();
    // box.erase();
    
    await OneSignal.shared.setAppId("75c4b2de-15ce-40d0-a53d-0170a067c8ce");
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    box.write("osUserID", osUserID);

    print(
        "=========OneSignal.shared player id======$osUserID======${box.read("osUserID")}=========");

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      debugPrint('NOTIFICATION OPENED HANDLER CALLED WITH: $result');

      debugPrint(
          '========================NOTIFICATION OPENED HANDLER CALLED WITH: ${result.notification.title}=========');

      if (result.notification.title == "Vaccination Pending") {
        Get.offAll(HomeView(
          currentIndex: 1,
        ));
      }

      debugPrint(
          "====================push notifaiavtion===========================");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => NotificationsScreen()),
      // );
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Color(0xfff544099),
      initialBinding: NetworkBinding(),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // create an instance
  final NetworkController _networkManager = Get.find<NetworkController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Network Status',
              style: TextStyle(fontSize: 20),
            ),
            //update the Network State
            GetBuilder<NetworkController>(
                builder: (builder) => Text(
                      (_networkManager.connectionType == 0)
                          ? 'No Internet'
                          : (_networkManager.connectionType == 1)
                              ? 'You are Connected to Wifi'
                              : 'You are Connected to Mobile Internet',
                      style: TextStyle(fontSize: 30),
                    )),
          ],
        ),
      ),
    );
  }
}
