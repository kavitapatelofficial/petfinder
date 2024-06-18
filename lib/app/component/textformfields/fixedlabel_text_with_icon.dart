import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/constent/colors.dart';

class FixedLabelTextFormFieldIcon extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Widget? icon;
  final IconData prefixIcon;
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final VoidCallback? ontab;
  final bool? read;

  const FixedLabelTextFormFieldIcon(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.icon,
      required this.prefixIcon,
      this.validate,
      this.controller,
      this.keyboardType,
      this.ontab,
      this.read})
      : super(key: key);

  @override
  State<FixedLabelTextFormFieldIcon> createState() =>
      _FixedLabelTextFormFieldIconState();
}

class _FixedLabelTextFormFieldIconState
    extends State<FixedLabelTextFormFieldIcon> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          widget.prefixIcon,
          color: AppColor.accentLightGrey,
          size: 34,
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: HexColor("#E5E4F2"),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              controller: widget.controller,
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                color: HexColor("#828282"),
                fontWeight: FontWeight.w400,
              ),
              onChanged: (value) {},
              validator: widget.validate,

              decoration: InputDecoration(
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusColor: Colors.white,
                //add prefix icon
                // ignore: prefer_const_constructors
                suffixIcon: widget.icon,

                border: InputBorder.none,
                filled: true,
                fillColor: HexColor("#E5E4F2"),

                hintText: widget.hintText,

                //make hint text
                // ignore: prefer_const_constructors
                hintStyle: TextStyle(
                  color: HexColor("#49454F"),
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                ),
                //create lable
                labelText: widget.labelText,
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
      ],
    );
  }
}
