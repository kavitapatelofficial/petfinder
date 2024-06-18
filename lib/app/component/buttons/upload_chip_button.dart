
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constent/colors.dart';

class UploadChipButton extends StatelessWidget {
  const UploadChipButton({
    Key? key,
    this.press,
    this.textColor = Colors.black,
    required this.text, required this.showicon,
  }) : super(key: key);
  final String text;

  final Function()? press;
  final Color? textColor;
  final bool showicon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.zero,
      width: size.width*0.7,
      decoration: BoxDecoration(
        color: AppColor.accentWhite,
        border: Border.all(color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: HexColor("#40000000"),
              // blurRadius: 1.0,
              offset: const Offset(0.2, 0.4))
        ],
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
            showicon==true?
            Icon(Icons.upload,color:AppColor.primaryColor,):const SizedBox(height: 0,
            width: 0,),
            const SizedBox(width: 10,),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1,
                  color: AppColor.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lato'),
            ),
          ],
        ),
      ),
    );
  }
}
