import 'package:flutter/material.dart';
import 'package:front_moon_srs/shared/themes/app_colors.dart';
import 'package:front_moon_srs/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/routes.dart' as route;

class AppBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.space * 5),
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, route.home, (route) => false);
            },
            child: Icon(
              Icons.house_rounded,
              color: AppColors.primary,
              size: 35,
            ),
          ),
          Icon(
            Icons.account_circle_rounded,
            color: AppColors.primary,
            size: 35,
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
