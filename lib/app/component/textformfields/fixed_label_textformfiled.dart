import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FixedLabelTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Widget? icon;
  final int? maxlength;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validate;
  final TextInputType? keyboardType;
  final String? prefixText;
  final Iterable<String>? autofill;

  const FixedLabelTextFormField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.icon,
      this.controller,
      this.onChanged,
      this.validate,
      this.keyboardType,
      this.prefixText,
      this.autofill,
      this.maxlength})
      : super(key: key);

  @override
  State<FixedLabelTextFormField> createState() =>
      _FixedLabelTextFormFieldState();
}

class _FixedLabelTextFormFieldState extends State<FixedLabelTextFormField> {
  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: TextFormField(
        maxLength:widget.maxlength,
        controller: widget.controller,
        autofillHints: widget.autofill,

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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
          border: InputBorder.none,
          filled: true,
          fillColor: HexColor("#E5E4F2"),
          counterText: "",

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
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: widget.validate,
      ),
    );
  }
}
