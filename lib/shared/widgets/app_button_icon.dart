import 'package:flutter/material.dart';
import 'package:front_moon_srs/shared/themes/app_colors.dart';

class AppButtonIcon extends StatelessWidget {
  IconData? icon;
  Color? iconColor;
  double iconSize;
  double? width;
  double? height;
  double? fontSize;
  Color? bgColor;
  var onPressed;

  AppButtonIcon(
      {Key? key,
      required this.onPressed,
      this.iconColor,
      this.iconSize = 22,
      this.icon,
      this.width,
      this.height,
      this.bgColor,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.25,
      height: height ?? MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(bgColor ?? AppColors.primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45.0),
            ),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Container(
          margin: EdgeInsets.zero,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(
              icon ?? Icons.add,
              color: iconColor ?? AppColors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
