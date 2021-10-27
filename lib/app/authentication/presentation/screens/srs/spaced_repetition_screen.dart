import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app/authentication/presentation/screens/srs/spaced_repetition.store.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/app/shared/widgets/app_bottom_bar.dart';
import 'package:front_moon_srs/app/shared/widgets/app_button_text.dart';
import 'package:front_moon_srs/app/shared/widgets/app_loading.dart';
import 'package:front_moon_srs/app/shared/widgets/app_top_bar.dart';

class SpacedRepetitionScreen extends StatefulWidget {
  const SpacedRepetitionScreen({Key? key}) : super(key: key);

  static const String route = "spacedRepetition";

  @override
  _SpacedRepetitionScreenState createState() => _SpacedRepetitionScreenState();
}

class _SpacedRepetitionScreenState extends State<SpacedRepetitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation _animation;

  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  Color? priorityColor = AppColors.primary;

  int priority = 0;

  final SpacedRepetitionStore _spacedRepetitionStore = SpacedRepetitionStore();

  @override
  void initState() {
    super.initState();

    setState(() {
      _spacedRepetitionStore.init(context);

      _animationController = AnimationController(
          vsync: this, duration: const Duration(seconds: 1));
      _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          _animationStatus = status;
        });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: AppTobBar(),
        elevation: 0,
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) => (AppLoading(
            status: _spacedRepetitionStore.isLoading,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimens.space * 2),
              child: Observer(
                builder: (_) => (Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _card(),
                    SizedBox(height: AppDimens.space * 6),
                    (!_spacedRepetitionStore.isCardNull)
                        ? _cardButtons()
                        : Container()
                  ],
                )),
              ),
            ),
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _spacedRepetitionStore.answerCard(priority);
          _animationController.reset();
          priorityColor = AppColors.primary;
          await _spacedRepetitionStore.getCardByReleaseDate();
        },
        backgroundColor: AppColors.primary,
        splashColor: AppColors.red,
        icon: const Icon(Icons.navigate_next_rounded),
        label: Text(
          "next",
          style: AppTextStyles.smallContentWhite,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.white,
        child: AppBottomBar(),
      ),
    );
  }

  _card() {
    return (!_spacedRepetitionStore.isCardNull)
        ? Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(pi * _animation.value),
            child: GestureDetector(
              onTap: () {
                if (_animationStatus == AnimationStatus.dismissed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              },
              child: _animation.value <= 0.5
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      fit: StackFit.loose,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: AppDimens.space),
                          padding: EdgeInsets.all(AppDimens.space * 3),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppDimens.space * 2),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  _spacedRepetitionStore.cardModel.front,
                                  style: AppTextStyles.cardContentBig,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(bottom: AppDimens.space),
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.space * 3),
                          decoration: BoxDecoration(
                            color: priorityColor,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(AppDimens.space * 2),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Transform(
                      alignment: FractionalOffset.center,
                      transform: Matrix4.identity()
                        ..rotateY(pi * 3)
                        ..invertRotation(),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        fit: StackFit.loose,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: AppDimens.space),
                            padding: EdgeInsets.all(AppDimens.space * 3),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppDimens.space * 2),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    _spacedRepetitionStore.cardModel.back,
                                    style: AppTextStyles.cardContentBigLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            margin: EdgeInsets.only(bottom: AppDimens.space),
                            padding: EdgeInsets.symmetric(
                                horizontal: AppDimens.space * 3),
                            decoration: BoxDecoration(
                              color: priorityColor,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(AppDimens.space * 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          )
        : Center(
            child: Text(
            "cabo as carta",
            style: AppTextStyles.cardContentBig,
          ));
  }

  _cardButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButtonText(
          content: "eazy",
          bgColor: AppColors.green,
          onPressed: () async {
            priority = 0;
            priorityColor = AppColors.green;
            await _spacedRepetitionStore.getCardByReleaseDate();
          },
        ),
        AppButtonText(
          content: "medium",
          bgColor: AppColors.yellow,
          onPressed: () async {
            priority = 1;
            priorityColor = AppColors.yellow;
            await _spacedRepetitionStore.getCardByReleaseDate();
          },
        ),
        AppButtonText(
          content: "hard",
          bgColor: AppColors.red,
          onPressed: () async {
            priority = 2;
            priorityColor = AppColors.red;
            await _spacedRepetitionStore.getCardByReleaseDate();
          },
        ),
      ],
    );
  }
}
