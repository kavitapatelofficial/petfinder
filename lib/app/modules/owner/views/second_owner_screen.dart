import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp/app/component/no_found.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/model/all-owner_model.dart';
import 'package:petapp/app/model/all_co_owner_model.dart';
import 'package:petapp/app/model/common_error_model.dart';
import 'package:petapp/app/model/error_model.dart';
import 'package:petapp/app/modules/owner/views/update_coowner.dart';
import 'package:petapp/services/base_client.dart';

import '../../../component/headings/my_headingtext.dart';
import '../../../component/headings/my_row_text.dart';
import '../../../constent/colors.dart';

class SeconOwnerScreen extends StatefulWidget {
  const SeconOwnerScreen({Key? key}) : super(key: key);

  @override
  State<SeconOwnerScreen> createState() => _SeconOwnerScreenState();
}

class _SeconOwnerScreenState extends State<SeconOwnerScreen> {
  BaseClient baseClient = BaseClient();
  AllCoOwnerModel? allCoOwnerModel;
  CommonErrorModel? commonErrorModel;
  bool isLoading = true;

  AllOwnerModel? allownerModel;
  bool isOwLoading = true;

  getcoOwner() async {
    isLoading = true;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "/api/getCoowner/${BaseClient.box2.read("user_id")}");

    if (response == 400) {
      print("=============response========$response====${response == 400}==");
      print("==========================");

      // commonErrorModel = commonErrorModelFromJson(response);
    } else {
      print("=============response========$response====${response == 400}==");
      allCoOwnerModel = allCoOwnerModelFromJson(response);
    }

    isLoading = false;
    setState(() {});
  }

  getcoOwner2() async {
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "/api/getCoowner/${BaseClient.box2.read("user_id")}");
    allCoOwnerModel = allCoOwnerModelFromJson(response);

    setState(() {});
  }

  @override
  void initState() {
    getcoOwner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Container(
            height: 400,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : allCoOwnerModel == null
            ? noFound("No Co-owner not found!",null)
            : allCoOwnerModel!.owners!.isEmpty
                ? const Center(
                    child: Text("No Records Found"),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Column(
                        children: allCoOwnerModel!.owners!.map((e) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.accentWhite,
                          borderRadius:
                              BorderRadius.circular(10), //border corner radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), //color of shadow
                              spreadRadius: 5, //spread radius
                              blurRadius: 7, // blur radius
                              offset: const Offset(
                                  0, 2), // changes position of shadow
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
                                const MyBodyHeadingText(
                                    text: "Co - owner Details"),
                                InkWell(
                                  onTap: () {
                                    Get.to(UpdateCoOwnerDetails(
                                      coowner_id: e.id ?? "".toString(),
                                    ));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            RowText(text1: "Name", text2: e.name ?? ""),
                            RowText(
                                text1: "Phone",
                                text2: "${e.phone ?? "".toString()}"),
                            RowText(
                                text1: "Email Id",
                                text2: e.email ?? "".toString()),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      );
                    }).toList()),
                  );
  }
}
