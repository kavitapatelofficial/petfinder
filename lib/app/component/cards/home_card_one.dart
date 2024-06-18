import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/component/buttons/colored_upload_button.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';

import '../../../services/base_client.dart';

class HomeCard extends StatelessWidget {
  final String image;
  final String name;
  final String breed;
  final String year;
  final String gender;
  final String rfidNo;
  final VoidCallback onUpadate;
  final VoidCallback onDownload;
  final String? Function(String?)? onReview;
  final String hintText;
  final TextEditingController? writeNoteController;
  const HomeCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.year,
      required this.gender,
      required this.rfidNo,
      required this.onUpadate,
      required this.onDownload,
      required this.breed,
      required this.onReview,
      this.writeNoteController,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.accentWhite,
          borderRadius: BorderRadius.circular(10), //border corner radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: const Offset(0, 2), // changes position of shadow
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
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        onError: (exception, stackTrace) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "${ConstantsUrls.baseURL}/api/$image")),
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(30), //border corner radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 1, //spread radius
                        blurRadius: 7, // blur radius
                        offset:
                            const Offset(0, 0.2), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                ),
                BaseClient.box2.read("userLogin") == false
                    ? const SizedBox()
                    : Positioned(
                        top: 0,
                        right: 0,
                        child: Align(
                            child: InkWell(
                          onTap: onUpadate,
                          child: CircleAvatar(
                              backgroundColor: HexColor("#BFBE9090"),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 22,
                              )),
                        )))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyBodyHeadingText(text: "Hello, my.."),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Name",
                              style: Texttheme.title,
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              name,
                              textAlign: TextAlign.left,
                              style: Texttheme.subTitle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Breed",
                              style: Texttheme.title,
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              breed,
                              style: Texttheme.subTitle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Age",
                              style: Texttheme.title,
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              year,
                              style: Texttheme.subTitle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Gender",
                              style: Texttheme.title,
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              gender,
                              style: Texttheme.subTitle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 40,),
                          Expanded(
                            child: Text(
                              "RFID Number",
                              style: Texttheme.title,
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              rfidNo,
                              style: Texttheme.subTitle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ColoredUploadChipButton(
                      press: onDownload,
                      icon: "assets/Home/Download_down.png",
                      text: "Download the RFID Certificate",
                      showicon: true,
                      underline: true),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    // height: 40,
                    decoration: BoxDecoration(
                        color: HexColor("#40000000").withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        onFieldSubmitted: onReview,
                        onChanged: (value) {},
                        controller: writeNoteController,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // filled: true,

                          // isDense: true,
                          focusColor: Colors.white,
                          //add prefix icon
                          // ignore: prefer_const_constructors
                          prefixIcon: SizedBox(
                              height: 30,
                              width: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset("assets/Home/BallPen.png",
                                    height: 10, width: 10),
                              )),

                          fillColor: HexColor("#40000000").withOpacity(0.1),

                          hintText: hintText,

                          //make hint text
                          // ignore: prefer_const_constructors
                          hintStyle: TextStyle(
                            color: HexColor("#49454F"),
                            fontSize: 12,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable

                          //lable style
                          // ignore: prefer_const_constructors
                          labelStyle: TextStyle(
                            color: HexColor("#49454F"),
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
