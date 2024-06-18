import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/component/headings/my_row_text.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/model/user_detail_model.dart';
import 'package:petapp/app/modules/owner/views/update_owner_detail.dart';
import 'package:petapp/services/base_client.dart';

import '../../../constent/colors.dart';

class FirstOwner extends StatefulWidget {
  const FirstOwner({Key? key}) : super(key: key);

  @override
  State<FirstOwner> createState() => _FirstOwnerState();
}

class _FirstOwnerState extends State<FirstOwner> {
  BaseClient baseClient = BaseClient();

  UserDetailModel? allownerModel;
  bool isOwLoading = true;

  getOwner() async {
    isOwLoading = true;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getUser}${BaseClient.box2.read("user_id")}");
    allownerModel = userDetailModelFromJson(response);


    print("==================allownerModel====================$response=====================");
    isOwLoading = false;
    setState(() {});
  }

  getOwner2() async {
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getUser}${BaseClient.box2.read("user_id")}");
      
    allownerModel = userDetailModelFromJson(response);
    setState(() {});
  }

  @override
  void initState() {
    getOwner();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isOwLoading == true
        ? Container(
          height: 400,
        child: const Center(child: CircularProgressIndicator()))
        : allownerModel!.user == null
            ? const Center(
                child: Text("No Records Found"),
              )
            : allownerModel == null
                ? Text("=====${allownerModel!.user!.name}=========")
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColor.accentWhite,
                      borderRadius:
                          BorderRadius.circular(10), //border corner radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset:
                              const Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyBodyHeadingText(text: "Owner Details"),
                            BaseClient.box2.read("userLogin") == false
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      Get.to(AddOwnerDetail(
                                        userID: allownerModel!.user!.id ?? '',
                                      ));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ))
                          ],
                        ),
                        RowText(
                            text1: "Name",
                            text2: allownerModel!.user!.name == null
                                ? ''
                                : allownerModel!.user!.name!),
                        RowText(
                            text1: "Phone",
                            text2: allownerModel!.user!.phoneNumber == null
                                ? ''
                                : allownerModel!.user!.phoneNumber.toString()),
                        RowText(
                            text1: "Email Id",
                            text2: allownerModel!.user!.email == null
                                ? ''
                                : allownerModel!.user!.email!),
                        RowText(
                            text1: "Current Address",
                            text2: allownerModel!.user!.currentAddress == null
                                ? ""
                                : "${allownerModel!.user!.currentAddress!.add == null ? '' : allownerModel!.user!.currentAddress!.add} ${allownerModel!.user!.currentAddress!.city == null ? '' : allownerModel!.user!.currentAddress!.city} ${allownerModel!.user!.currentAddress!.state == null ? '' : allownerModel!.user!.currentAddress!.state}, ${allownerModel!.user!.currentAddress!.zip == null ? '' : allownerModel!.user!.currentAddress!.zip}"),
                        RowText(
                            text1: "Permanent Address",
                            text2: allownerModel!.user!.permanentAddress == null
                                ? ""
                                : "${allownerModel!.user!.permanentAddress!.add == null ? '' : allownerModel!.user!.permanentAddress!.add} ${allownerModel!.user!.permanentAddress!.city == null ? '' : allownerModel!.user!.permanentAddress!.city} ${allownerModel!.user!.permanentAddress!.state == null ? '' : allownerModel!.user!.permanentAddress!.state}, ${allownerModel!.user!.permanentAddress!.zip == null ? '' : allownerModel!.user!.permanentAddress!.zip}"),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
  }
}
