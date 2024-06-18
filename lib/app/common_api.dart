import 'dart:io';

import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/model/all_pet_model.dart';
import 'package:petapp/app/model/user_detail_model.dart';
import 'package:petapp/services/base_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
class CommonAPI {
 static BaseClient baseClient = BaseClient();


static Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }
}

 static getOwner() async {
    if (BaseClient.box2.read("user_id") != null) {
      var response = await baseClient.get(false, ConstantsUrls.baseURL,
          "${ConstantsUrls.getUser}${BaseClient.box2.read("user_id")}");
      var data = userDetailModelFromJson(response);
      if (data != null) {
        BaseClient.box2.write("name", data.user!.name);
        BaseClient.box2.write("email", data.user!.email);
        BaseClient.box2.write("phone", data.user!.phoneNumber);
      }
    }
  }

 static getallpet() async {
    if (BaseClient.box2.read("user_id") != null) {
      var response = await baseClient.get(false, ConstantsUrls.baseURL,
          "${ConstantsUrls.getAllPetByUser}${BaseClient.box2.read("user_id")}");
      if (response != null) {
        var data = allPetModelFromJson(response);

        if (data != null) {

          print("======fisrt pet detaila========================");
          BaseClient.box2.write("pet_name", data.result!.first.name);
          BaseClient.box2.write("pet_id", data.result!.first.id);
        }
      }
    }
  }
}
