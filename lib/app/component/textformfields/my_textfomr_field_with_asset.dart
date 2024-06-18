import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTextFormFieldAsset extends StatefulWidget {
  final String hintText;
  final Widget? icon;
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final VoidCallback? ontab;
  final bool? read;
  final Widget prefixIcon;

  const MyTextFormFieldAsset(
      {Key? key,
      required this.hintText,
      this.icon,
      this.validate,
      this.controller,
      this.keyboardType,
      this.ontab,
      this.read,
      required this.prefixIcon})
      : super(key: key);

  @override
  State<MyTextFormFieldAsset> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormFieldAsset> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ignore: prefer_const_constructors
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (value) {},
      validator: widget.validate,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onTap: widget.ontab,
      readOnly: widget.read == null ? false : widget.read!,

      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,

        isDense: true,
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

        //lable style
        // ignore: prefer_const_constructors
      ),
    );
  }
}
