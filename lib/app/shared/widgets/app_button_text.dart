import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';

class AppButtonText extends StatelessWidget {
  String content = "";
  double? width;
  double? height;
  double? fontSize;
  Color? textColor;
  Color? bgColor;
  var onPressed;

  AppButtonText(
      {Key? key,
      required this.content,
      required this.onPressed,
      this.width,
      this.height,
      this.textColor,
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
              borderRadius: BorderRadius.circular(16.0),
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
            child: Text(
              content,
              style: TextStyle(
                color: textColor ?? AppColors.white,
                fontSize: fontSize ?? 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
