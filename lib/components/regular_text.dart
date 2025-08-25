import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  const RegularText(this.text, {super.key, this.style, this.textAlign = TextAlign.start}); //this.text diletak diluar kurung kerawal karena komponen text dibuat default tanpa properti

  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  factory RegularText.title(String text, {
    TextAlign textAlign = TextAlign.start, })
    {
    return RegularText(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 24, 
        fontWeight: FontWeight.bold),
    );
  }

  factory RegularText.description(String text, {
    TextAlign textAlign = TextAlign.start, }){
    return RegularText(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey),
    );
  }

  factory RegularText.description2(String text, {
    TextAlign textAlign = TextAlign.center, }){
    return RegularText(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500
      ).merge(style),
    );
  }
}