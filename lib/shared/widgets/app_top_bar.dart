import 'package:flutter/material.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:front_moon_srs/data/services/auth.service.dart';
import 'package:front_moon_srs/data/services/collection.service.dart';
import 'package:front_moon_srs/shared/themes/app_colors.dart';
import 'package:front_moon_srs/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/shared/themes/app_text_styles.dart';

class AppTobBar extends StatelessWidget {
  final authService = serviceLocator<AuthService>();
  final collectionService = serviceLocator<CollectionService>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () async {
              collectionService.reset();
            },
            icon: Icon(
              Icons.menu_rounded,
              size: 30,
              color: AppColors.darkGrey,
            )),
        Row(
          children: [
            Text(
              authService.currentUser.userName,
              style: AppTextStyles.textPrimary,
            ),
            SizedBox(width: AppDimens.space),
            CircleAvatar(
              backgroundColor: AppColors.lightGrey,
            )
          ],
        )
      ],
    );
  }
}
