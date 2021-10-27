import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';

AppModal(
    {required BuildContext context,
    required String title,
    Widget? content,
    List<Widget>? actions}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: AppTextStyles.textPrimary,
        ),
        contentPadding: EdgeInsets.all(AppDimens.space * 2),
        buttonPadding:
            EdgeInsets.fromLTRB(0, 0, AppDimens.space * 2, AppDimens.space * 2),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.space * 2),
          ),
        ),
        content: content,
        actions: actions,
      );
    },
  );
}
