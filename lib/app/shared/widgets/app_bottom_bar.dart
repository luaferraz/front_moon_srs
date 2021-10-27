import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/core/routes/routes.dart';

class AppBottomBar extends StatelessWidget {
  bool showHome;
  bool showSettings;

  AppBottomBar({this.showHome = true, this.showSettings = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.space * 5),
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: showHome
                ? () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.home, (route) => false);
                  }
                : () {},
            child: Icon(
              Icons.house_rounded,
              color: AppColors.primary,
              size: 35,
            ),
          ),
          GestureDetector(
            onTap: showSettings
                ? () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.appSettings, (route) => false);
                  }
                : () {},
            child: Icon(
              Icons.settings,
              color: AppColors.primary,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  _iconBottomBar(String icon, String text) {
    return SizedBox(
      height: 55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            icon,
            height: 35,
            width: 35,
          ),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
