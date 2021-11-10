import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app/presentation/screens/srs/spaced_repetition.store.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/app/shared/widgets/app_bottom_bar.dart';
import 'package:front_moon_srs/app/shared/widgets/app_button_text.dart';
import 'package:front_moon_srs/app/shared/widgets/app_dialog.dart';
import 'package:front_moon_srs/app/shared/widgets/app_input.dart';
import 'package:front_moon_srs/app/shared/widgets/app_loading.dart';
import 'package:front_moon_srs/app/shared/widgets/app_top_bar.dart';

class SpacedRepetitionScreen extends StatefulWidget {
  const SpacedRepetitionScreen({Key? key}) : super(key: key);

  @override
  _SpacedRepetitionScreenState createState() => _SpacedRepetitionScreenState();
}

class _SpacedRepetitionScreenState extends State<SpacedRepetitionScreen>
    with SingleTickerProviderStateMixin {
  final SpacedRepetitionStore _spacedRepetitionStore = SpacedRepetitionStore();

  late AnimationController _animationController;

  late Animation _animation;

  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  Color? priorityColor = AppColors.primary;

  int priority = 0;

  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusCardBack = FocusNode();

  @override
  void initState() {
    super.initState();

    _spacedRepetitionStore.init(context);

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
      appBar: AppBar(
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
                        : Container(),
                  ],
                )),
              ),
            ),
          )),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: AppDimens.space * 4),
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () async {
                AppModal(
                  context: context,
                  title: "edit card",
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppInput(
                          hintText: "new front",
                          value: _spacedRepetitionStore.cardModel.front,
                          validator: _validatorNewFront,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          nextFocus: _focusCardBack,
                          onChange: (value) {
                            _spacedRepetitionStore.editCardModel.front = value;
                          },
                        ),
                        SizedBox(height: AppDimens.space * 2),
                        AppInput(
                          hintText: "new back",
                          value: _spacedRepetitionStore.cardModel.back,
                          validator: _validatorNewBack,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          focusNode: _focusCardBack,
                          onChange: (value) {
                            _spacedRepetitionStore.editCardModel.back = value;
                          },
                        ),
                        SizedBox(height: AppDimens.space * 2),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cancelButton(),
                        AppButtonText(
                          content: "edit",
                          bgColor: AppColors.primary,
                          onPressed: () async {
                            if (_spacedRepetitionStore.editCardModel.front ==
                                "") {
                              _spacedRepetitionStore.editCardModel.front =
                                  _spacedRepetitionStore.cardModel.front;
                            }
                            if (_spacedRepetitionStore.editCardModel.back ==
                                "") {
                              _spacedRepetitionStore.editCardModel.back =
                                  _spacedRepetitionStore.cardModel.back;
                            }

                            bool ret = await _spacedRepetitionStore
                                .editCard(_spacedRepetitionStore.cardModel.id);
                            Navigator.pop(context);

                            if (ret) {
                              AppModal(context: context, title: "card edited!");
                              setState(() {
                                _spacedRepetitionStore.cardModel.front =
                                    _spacedRepetitionStore.editCardModel.front;
                                _spacedRepetitionStore.cardModel.back =
                                    _spacedRepetitionStore.editCardModel.back;
                              });
                            } else {
                              _errorModal(
                                  errorMessage:
                                      "error ${_spacedRepetitionStore.errorMessage}");
                            }
                          },
                        )
                      ],
                    )
                  ],
                );
              },
              backgroundColor: AppColors.darkGrey,
              splashColor: AppColors.red,
              icon: const Icon(Icons.edit),
              label: Text(
                "edit card",
                style: AppTextStyles.smallContentWhite,
              ),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              if (priorityColor == AppColors.primary) {
                return AppModal(
                    context: context, title: "select an difficulty first!");
              } else {
                await _spacedRepetitionStore.answerCard(priority);
                _animationController.reset();
                priorityColor = AppColors.primary;
                await _spacedRepetitionStore.getCardByReleaseDate();
              }
            },
            backgroundColor: AppColors.primary,
            splashColor: AppColors.red,
            icon: const Icon(Icons.navigate_next_rounded),
            label: Text(
              "next",
              style: AppTextStyles.smallContentWhite,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
                          padding: EdgeInsets.fromLTRB(
                              AppDimens.space * 2, 0, AppDimens.space * 2, 45),
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
                            padding: EdgeInsets.fromLTRB(AppDimens.space * 2, 0,
                                AppDimens.space * 2, 45),
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
            "no more cards for today",
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
            setState(() {
              priority = 0;
              priorityColor = AppColors.green;
            });
          },
        ),
        AppButtonText(
          content: "medium",
          bgColor: AppColors.yellow,
          onPressed: () async {
            setState(() {
              priority = 1;
              priorityColor = AppColors.yellow;
            });
          },
        ),
        AppButtonText(
          content: "hard",
          bgColor: AppColors.red,
          onPressed: () async {
            setState(() {
              priority = 2;
              priorityColor = AppColors.red;
            });
          },
        ),
      ],
    );
  }

  String? _validatorNewFront(String? front) {
    if (front!.isEmpty) return "cannot be empty";
    if (front.length > 100) return "card can't have more than 100 characters";
  }

  String? _validatorNewBack(String? back) {
    if (back!.isEmpty) return "cannot be empty";
    if (back.length > 100) return "card cant have more than 100 characters";
  }

  void _errorModal({String errorMessage = ""}) {
    AppModal(
      context: context,
      title: errorMessage == ""
          ? "there was an error while trying to edit the card ${_spacedRepetitionStore.errorMessage}"
          : errorMessage,
      actions: [
        AppButtonText(
          height: MediaQuery.of(context).size.height * 0.03,
          width: MediaQuery.of(context).size.width * 0.3,
          content: "ok",
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  _cancelButton() {
    return AppButtonText(
      content: "cancel",
      bgColor: AppColors.primary,
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }
}
