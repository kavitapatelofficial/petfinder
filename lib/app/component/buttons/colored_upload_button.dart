
import 'package:flutter/material.dart';

import '../../constent/colors.dart';

class ColoredUploadChipButton extends StatelessWidget {
  const ColoredUploadChipButton({
    Key? key,
    this.press,
    this.textColor = Colors.black,
    required this.text,
    required this.showicon,
    this.underline, this.icon,
  }) : super(key: key);
  final String text;

  final Function()? press;
  final Color? textColor;
  final bool showicon;
  final String? icon;
  final bool? underline;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.zero,
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color:
            underline == true ? AppColor.accentWhite : AppColor.accentLightGrey,
        border: Border.all(
          color: underline == true ? AppColor.accentWhite : AppColor.accentLightGrey,
        ),
        borderRadius: BorderRadius.circular(8),
       
      ),
      height: 50,
      child: newElevatedButton(),
    );
  }

  Widget newElevatedButton() {
    return InkWell(
      onTap: press,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             const SizedBox(
              width: 5,
            ),
            showicon == true
                ? Image.asset(
                    "$icon",
                    color: AppColor.defaultBlackColor,
                    height: 16,
                    width: 16,
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
           
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  
                    letterSpacing: 1,
                    color: textColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Open Sans',
                    decoration: underline == true
                        ? TextDecoration.underline
                        : TextDecoration.none),
              ),
            ),
             const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
