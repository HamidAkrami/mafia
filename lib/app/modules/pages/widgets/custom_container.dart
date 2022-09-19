import 'package:flutter/material.dart';
import 'package:mafia/app/core/value/colors.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer(
      {Key? key,
      this.color = grey,
      this.height = 120,
      this.width = 120,
      this.borderColor = grey,
      this.style,
      this.radius,
      this.border = 0,
      required this.text})
      : super(key: key);
  double? border;
  Color? borderColor;
  Color? color;
  double? width;
  double? height;
  String? text;
  TextStyle? style = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);
  double? radius = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color!,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: border!, color: borderColor!)),
      child: Text(
        text!,
        textScaleFactor: 0.8,
        style: style,
      ),
    );
  }
}
