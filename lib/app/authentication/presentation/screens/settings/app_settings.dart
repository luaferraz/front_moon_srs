import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/app/shared/widgets/app_bottom_bar.dart';
import 'package:front_moon_srs/app/shared/widgets/app_top_bar.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  static const String route = "appSettingsScreen";

  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: AppTobBar(),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) => Container(
            margin: EdgeInsets.all(AppDimens.space),
            child: Column(
              children: [
                _settingsInfo(),
                _settingFields(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.white,
        child: AppBottomBar(
          showSettings: false,
        ),
      ),
    );
  }

  _settingsInfo() {
    return Column(
      children: [
        Text(
          "settings",
          style: AppTextStyles.titleHome,
        ),
        SizedBox(
          height: AppDimens.space,
        )
      ],
    );
  }

  _settingFields() {
    return Column();
  }
}
