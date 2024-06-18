import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.press,
    this.textColor = Colors.white,
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
      width: size.width*0.7,
    
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: HexColor("#40000000"),
              // blurRadius: 1.0,
              offset: const Offset(0.2, 0.4))
        ],


         gradient: LinearGradient(
          stops: const [0.0,0.1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [HexColor("#544099"), HexColor("#4123A9"),])
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
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Lato'),
        ),
      ),
    );
  }
}
