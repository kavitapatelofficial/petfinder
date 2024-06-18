import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:get/get.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/modules/pet/views/pet_missing_detail.dart';
import 'package:petapp/services/base_client.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constent/api_urls.dart';

onAlertButtonsPressed(context, String petid,String petName) {
  BaseClient baseClient = BaseClient();
  Alert(
    style: AlertStyle(titleStyle: Texttheme.heading2),
    context: context,
    title: "Are you sure you want to report $petName missing?",
    content: Image.asset(
      "assets/Home/error.png",
      height: 96,
      width: 96,
    ),
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: AppColor.primaryColor,
        child: const Text(
          "No",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      DialogButton(
        border: Border.all(color: AppColor.primaryColor),
        onPressed: () async{

           Get.to( PetMissingDetail(petId: petid,));
         
          
          
        },
        color: AppColor.accentWhite,
        child: const Text(
          "Yes",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      )
    ],
  ).show();
}
