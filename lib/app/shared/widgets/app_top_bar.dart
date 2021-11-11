import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/authentication/data/services/auth.service.dart';
import 'package:front_moon_srs/app/authentication/data/services/collection.service.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/core/app_config.dart';
import 'package:front_moon_srs/core/routes/routes.dart';
import 'package:front_moon_srs/core/service_locator.dart';

import '../../../app.dart';

enum _MenuValues {
  logout,
}

class AppTobBar extends StatelessWidget {
  final authService = serviceLocator<AuthService>();
  final collectionService = serviceLocator<CollectionService>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppConfig.WHERE_AM_I != ""
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: AppColors.red,
                ),
                child: Text(
                  "${AppConfig.WHERE_AM_I}",
                  style: AppTextStyles.smallContentWhite,
                ),
              )
            : Container(),
        PopupMenuButton<_MenuValues>(
          offset: const Offset(0, 45),
          color: AppWidget.themeNotifier.value == ThemeMode.light
              ? AppColors.lightGrey
              : AppColors.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.space * 2),
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: _MenuValues.logout,
              child: Row(
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    width: AppDimens.space,
                  ),
                  Text(
                    "logout",
                    style: AppWidget.themeNotifier.value == ThemeMode.light
                        ? AppTextStyles.textInputDark
                        : AppTextStyles.textInput,
                  ),
                ],
              ),
            )
          ],
          onSelected: (value) {
            switch (value) {
              case _MenuValues.logout:
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.login, (route) => false);
                break;
            }
          },
          child: Row(
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
          ),
        )
      ],
    );
  }
}
