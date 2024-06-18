import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constent/colors.dart';

class OutlinedRoundedButton extends StatelessWidget {
  const OutlinedRoundedButton({
    Key? key,
    this.press,
    this.textColor = Colors.black,
    required this.text,
  }) : super(key: key);
  final String text;

  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.zero,
      width: size.width * 0.7,
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
      height: 40,
      child: newElevatedButton(),
    );
  }

  Widget newElevatedButton() {
    return InkWell(
      onTap: press,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              letterSpacing: 1,
              color: AppColor.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Lato'),
        ),
      ),
    );
  }
}
