import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextFormFieldIcon extends StatefulWidget {
  final String hintText;
  final Widget? icon;
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final VoidCallback? ontab;
  final bool? read;

  const TextFormFieldIcon({
    Key? key,
    required this.hintText,
    this.icon,
    this.controller,
    this.keyboardType,
    this.ontab,
    this.read,
    this.validate,
  }) : super(key: key);

  @override
  State<TextFormFieldIcon> createState() => _TextFormFieldIconState();
}

class _TextFormFieldIconState extends State<TextFormFieldIcon> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
       autovalidateMode: AutovalidateMode.onUserInteraction,
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
       readOnly: widget.read==null?false:widget.read!,
      decoration: InputDecoration(
        // isDense: true,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
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

        //create lable

        //lable style
        // ignore: prefer_const_constructors
        hintStyle: TextStyle(
          color: HexColor("#49454F"),
          fontSize: 16,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
