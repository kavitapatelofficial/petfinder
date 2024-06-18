// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:pinput/pinput.dart';

class Filled extends StatefulWidget {
  final String? Function(String?)? validate;
  final String? Function(String?)? onChanged;
  final TextEditingController controller;

  const Filled({super.key, this.validate, this.onChanged, required this.controller});
  @override
  _FilledState createState() => _FilledState();

  @override
  String toStringShort() => 'Filled';
}

class _FilledState extends State<Filled> {

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 42,
      height: 42,
      textStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColor.accentLightGrey),
    );

    return Container(
      width: 243,
      // clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Pinput(
        length: 4,
        controller: widget.controller,
        focusNode: focusNode,
        onChanged: widget.onChanged,
        validator: widget.validate,
        separator: Container(
          height: 42,
          
          width: 1,
          color: Colors.white,
        ),
        defaultPinTheme: defaultPinTheme,
        showCursor: true,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(color: AppColor.accentLightGrey
          ),
        ),
      ),
    );
  }
}