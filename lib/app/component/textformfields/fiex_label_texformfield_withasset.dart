import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FixedLabelTextFormFieldIAsset extends StatefulWidget {
   final String labelText;
  final String hintText;
  final Widget? icon;
  final bool? read;

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;
  final TextInputType? keyboardType;
  final String? prefixText;
  final Widget prefixIcon;
  const FixedLabelTextFormFieldIAsset(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.icon,
     
      this.validate,
      this.controller,
      this.keyboardType,
      this.onChanged, this.prefixText, this.read, required this.prefixIcon})
      : super(key: key);

  @override
  State<FixedLabelTextFormFieldIAsset> createState() =>
      _FixedLabelTextFormFieldIconState();
}

class _FixedLabelTextFormFieldIconState
    extends State<FixedLabelTextFormFieldIAsset> {
   @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      // ignore: prefer_const_constructors
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,

      decoration: InputDecoration(
        prefixIcon: widget,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        border: InputBorder.none,
        filled: true,
        fillColor: HexColor("#E5E4F2"),
       
//  labelText: "Label",
        //  border: InputBorder.none,
        //  border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        // isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusColor: Colors.white,
        //add prefix icon
        // ignore: prefer_const_constructors
        suffixIcon: Container(
            padding: const EdgeInsets.only(left: 20, bottom: 15, top: 15),
            // color: AppColor.pinkColor,
            height: 10,
            width: 10,
            child: widget.icon),

        hintText: widget.hintText,

        //make hint text
        // ignore: prefer_const_constructors
        hintStyle: TextStyle(
          // color: HexColor("#49454F"),
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
      validator: widget.validate,
    );
  }
}
