import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ColoredMyTextFormField extends StatefulWidget {
  final String hintText;
  final Widget? icon;

  const ColoredMyTextFormField({Key? key, required this.hintText, this.icon})
      : super(key: key);

  @override
  State<ColoredMyTextFormField> createState() => _ColoredMyTextFormFieldState();
}

class _ColoredMyTextFormFieldState extends State<ColoredMyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ignore: prefer_const_constructors
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: 16,
        color: HexColor("#828282"),
        fontWeight: FontWeight.w400,
      ),
      onChanged: (value) {},

      decoration: InputDecoration(

        border: InputBorder.none,
        filled: true,

        isDense: true,
        focusColor: Colors.white,
        //add prefix icon
        // ignore: prefer_const_constructors
        prefixIcon: SizedBox(
          height: 30,
          width: 30,
          child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget.icon,
        )),

      

       
        fillColor: HexColor("#40000000").withOpacity(0.1),

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
        labelStyle: TextStyle(
          color: HexColor("#49454F"),
          fontSize: 16,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
