import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final String? fontFamily;
  final int? maxLines;
  const CustomText({required this.text, this.fontWeight,Key? key, this.fontSize, this.color=Colors.white, this.textAlign,this.fontFamily, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight:fontWeight,
        fontSize: fontSize,
        color: color ,
        fontFamily: fontFamily,
        overflow: TextOverflow.ellipsis
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}