import 'package:flutter/material.dart';
import 'package:petapp/app/component/buttons/colored_upload_button.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';

class VacinationTrackerCard extends StatelessWidget {
  final String titletext;
  final String buttontext;
  final String date;
  final String icon1;
  final bool? shownotCompleted;
  final bool? showCertficatdOrNot;
  final String icon2;
  final bool? showPreview;
  final VoidCallback? onPress;
  final VoidCallback? onShow;
  const VacinationTrackerCard(
      {Key? key,
      required this.titletext,
      required this.buttontext,
      required this.date,
      required this.icon1,
      required this.icon2,
      this.showPreview,
      this.onPress,
      this.onShow,
      this.shownotCompleted = false,
      this.showCertficatdOrNot = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(titletext, style: Texttheme.title),
                Text("${shownotCompleted == true ? "" : "(not completed)"}",
                    style: Texttheme.title.copyWith(
                        color: Colors.red, fontStyle: FontStyle.italic)),
              ],
            ),
            Text(date, style: Texttheme.subTitle),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      icon2,
                      height: 40,
                      color: showPreview == true
                          ? Colors.black
                          : AppColor.accentLightGrey,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: showPreview == true
                            ? CircleAvatar(
                                radius: 7,
                                backgroundColor: Colors.green,
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.red,
                              ))
                  ],
                ),
                showPreview == true
                    ? GestureDetector(
                        onTap: onShow,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          color: Color(0xffD5CBF6),
                          child: const Text("Preview"),
                        ),
                      )
                    : const SizedBox()
              ],
            )),
            showCertficatdOrNot == true
                ? Expanded(
                    child: SizedBox(
                    height: 30,
                    child: ColoredUploadChipButton(
                      text: buttontext,
                      showicon: true,
                      underline: false,
                      icon: icon1,
                      press: onPress,
                    ),
                  ))
                : SizedBox(),
          ],
        )
      ],
    );
  }
}
