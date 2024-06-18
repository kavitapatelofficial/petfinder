import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String hinttext;
  final String labeltext;
  final String? Function(String?)? valiadte;
  final void Function(String?)? onChange;
  final void Function(String?)? onSave;
  final List< DropdownMenuItem<String>> items;
  const CustomDropdownField(
      {super.key,
      required this.hinttext,
      required this.items,
      required this.valiadte,
      this.onChange,
      this.onSave,
      required this.labeltext});

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        labelText: widget.labeltext,
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        '${widget.hinttext}',
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: widget.items,
         
      validator: widget.valiadte,
      onChanged: widget.onChange,
      onSaved: widget.onSave,
    );
  }
}
