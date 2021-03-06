import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app.dart';
import 'package:front_moon_srs/app/authentication/data/sources/locar_storage.source.dart';
import 'package:front_moon_srs/app/presentation/screens/settings/app_settings.store.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/app/shared/widgets/app_bottom_bar.dart';
import 'package:front_moon_srs/app/shared/widgets/app_top_bar.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  final AppSettingsStore _appSettingsStore = AppSettingsStore();
  bool isDark = false;

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTobBar(),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(AppDimens.space),
          child: Column(
            children: [
              _settingsInfo(),
              _settingsFields(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
          style: AppWidget.themeNotifier.value == ThemeMode.light
              ? AppTextStyles.titleHomeDark
              : AppTextStyles.titleHome,
        ),
        SizedBox(
          height: AppDimens.space,
        )
      ],
    );
  }

  _settingsFields() {
    return Column(
      children: [
        _fieldContainer(
          _toggleDarkMode(),
        )
      ],
    );
  }

  _fieldContainer(Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.space),
      padding: EdgeInsets.all(AppDimens.space * 2),
      decoration: BoxDecoration(
        color: AppWidget.themeNotifier.value == ThemeMode.light
            ? AppColors.lightGrey
            : AppColors.darkGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimens.space * 2),
        ),
      ),
      child: child,
    );
  }

  _toggleDarkMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "toggle dark mode",
          style: AppWidget.themeNotifier.value == ThemeMode.light
              ? AppTextStyles.titleSecondaryDark
              : AppTextStyles.titleSecondary,
        ),
        CupertinoSwitch(
          value:
              AppWidget.themeNotifier.value == ThemeMode.light ? false : true,
          onChanged: (value) {
            setState(
              () {
                _appSettingsStore.isDark = value;
                _appSettingsStore.setCurrentTheme();
              },
            );
          },
        ),
      ],
    );
  }
}
