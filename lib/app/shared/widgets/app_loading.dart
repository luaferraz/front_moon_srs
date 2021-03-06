import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';

import '../../../app.dart';

class AppLoading extends StatefulWidget {
  final bool backgroundTransparent;
  final String message;
  final bool status;
  final Widget child;

  const AppLoading(
      {Key? key,
      required this.status,
      required this.child,
      this.message = "",
      this.backgroundTransparent = false})
      : super(key: key);

  @override
  _AppLoadingState createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[widget.child, _loading(widget.status)]);
  }

  Widget _loading(bool loading) {
    return loading == true
        ? Container(
            alignment: Alignment.center,
            color: widget.backgroundTransparent == true
                ? Colors.transparent
                : AppWidget.themeNotifier.value == ThemeMode.light
                    ? AppColors.white
                    : AppColors.bgDark,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(widget.message)),
                CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ],
            ),
          )
        : Container();
  }
}
