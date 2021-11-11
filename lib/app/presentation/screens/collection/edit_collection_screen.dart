import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app/authentication/data/models/card.model.dart';
import 'package:front_moon_srs/app/presentation/screens/collection/edit_collection.store.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/app/shared/widgets/app_bottom_bar.dart';
import 'package:front_moon_srs/app/shared/widgets/app_button_icon.dart';
import 'package:front_moon_srs/app/shared/widgets/app_button_text.dart';
import 'package:front_moon_srs/app/shared/widgets/app_dialog.dart';
import 'package:front_moon_srs/app/shared/widgets/app_input.dart';
import 'package:front_moon_srs/app/shared/widgets/app_loading.dart';
import 'package:front_moon_srs/app/shared/widgets/app_top_bar.dart';
import 'package:front_moon_srs/core/routes/routes.dart';

import '../../../../app.dart';

class EditCollectionScreen extends StatefulWidget {
  const EditCollectionScreen({Key? key}) : super(key: key);

  @override
  _EditCollectionScreenState createState() => _EditCollectionScreenState();
}

class _EditCollectionScreenState extends State<EditCollectionScreen> {
  final EditCollectionStore _editCollectionStore = EditCollectionStore();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusCardBack = FocusNode();
  final FocusNode _focusNewCardBack = FocusNode();

  bool undo = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _editCollectionStore.init(context);
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
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          _collectionInfo(),
          _searchCard(),
          Expanded(
              child: Observer(
            builder: (_) => (AppLoading(
              status: _editCollectionStore.isLoading,
              child: ListView(
                children: [
                  _collectionCards(),
                ],
              ),
            )),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        elevation: 10,
        onPressed: () {
          _createCard();
        },
        child: const Icon(Icons.add, size: 30),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: AppBottomBar(),
      ),
    );
  }

  _collectionInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      margin: EdgeInsets.only(bottom: AppDimens.space),
      padding: EdgeInsets.symmetric(horizontal: AppDimens.space * 3),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppDimens.space * 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Observer(
            builder: (_) => (Text(
              _editCollectionStore.collectionService.selectedCollection.name,
              style: AppTextStyles.smallContentWhite,
            )),
          ),
          Row(
            children: [
              Observer(
                builder: (_) => (Text(
                  _editCollectionStore.collectionCards.length.toString(),
                  style: AppTextStyles.smallContentWhite,
                )),
              ),
              SizedBox(
                width: AppDimens.space,
              ),
              Image.asset(
                "assets/icons/card_icon.png",
              ),
              SizedBox(
                width: AppDimens.space * 3,
              ),
              AppButtonIcon(
                width: AppDimens.space * 7,
                bgColor: AppColors.white,
                iconColor: AppColors.primary,
                icon: Icons.edit,
                onPressed: () {
                  _modalCollection();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  _searchCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.space),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppInput(hintText: "search card", onChange: (value) {}),
              ),
              Icon(
                Icons.search_rounded,
                color: AppColors.primary,
                size: MediaQuery.of(context).size.height * 0.06,
              )
            ],
          ),
          SizedBox(
            height: AppDimens.space,
          )
        ],
      ),
    );
  }

  _collectionCards() {
    return Column(
      children: [
        (_editCollectionStore.collectionCards.isNotEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _editCollectionStore.collectionCards.length,
                itemBuilder: (context, index) {
                  return _card(
                      _editCollectionStore.collectionCards[index], index);
                },
              )
            : Column(
                children: const [
                  Text("nenhum"),
                ],
              ),
      ],
    );
  }

  _card(CardModel collectionCard, int index) {
    return Dismissible(
      key: UniqueKey(),
      background: _deleteSwapBg(),
      onDismissed: (direction) async {
        _showSnackBar(context, collectionCard, index);
        await _editCollectionStore.deleteCard(collectionCard.id);
        await _editCollectionStore.refreshCardList();
      },
      child: Column(
        children: [
          Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("front: ", style: AppTextStyles.textPrimary),
                          Expanded(
                            child: Text(
                              collectionCard.front,
                              style: AppTextStyles.textInput,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimens.space * 0.3),
                      Row(
                        children: [
                          Text("back: ", style: AppTextStyles.textPrimary),
                          Expanded(
                            child: Text(
                              collectionCard.back,
                              style: AppTextStyles.textInput,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimens.space * 0.3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("priority: ", style: AppTextStyles.textPrimary),
                          _cardPriority(priority: collectionCard.priority),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _cardCollectionModal(collectionCard);
                  },
                  child: Container(
                    margin: EdgeInsets.all(AppDimens.space),
                    padding: EdgeInsets.all(AppDimens.space),
                    width: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppDimens.space * 2))),
                    child: Center(
                      child: Icon(
                        Icons.edit_rounded,
                        color: AppColors.white,
                        size: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimens.space),
        ],
      ),
    );
  }

  _createCard() {
    return AppModal(
      context: context,
      title: "create card",
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInput(
                hintText: "front",
                validator: _validatorFront,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChange: (value) {
                  _editCollectionStore.cardModel.front = value;
                }),
            SizedBox(height: AppDimens.space),
            AppInput(
              hintText: "back",
              validator: _validatorBack,
              onChange: (value) {
                _editCollectionStore.cardModel.back = value;
              },
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _cancelButton(refresh: true),
            AppButtonText(
              content: "create",
              onPressed: () async {
                bool formOk = _formKey.currentState!.validate();

                if (!formOk) return;

                Navigator.pop(context);
                bool ret = await _editCollectionStore.createCard();

                if (ret) {
                  AppModal(context: context, title: "card created!", actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtonText(
                          content: "ok",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        AppButtonText(
                            content: "create new",
                            onPressed: () async {
                              Navigator.pop(context);
                              _createCard();
                            }),
                      ],
                    ),
                  ]);
                } else {
                  AppModal(
                    context: context,
                    title: _editCollectionStore.errorMessage,
                    actions: [
                      AppButtonText(
                        content: "done",
                        onPressed: () async {
                          Navigator.pop(context);
                          await _editCollectionStore.refreshCardList();
                        },
                      ),
                    ],
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }

  _cardPriority({int priority = 0}) {
    if (priority == 0) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimens.space),
        height: MediaQuery.of(context).size.height * 0.02,
        padding: EdgeInsets.symmetric(horizontal: AppDimens.space),
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.space * 2),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "low",
            style: AppTextStyles.smallerContent,
          ),
        ),
      );
    } else if (priority == 1) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimens.space),
        height: MediaQuery.of(context).size.height * 0.02,
        padding: EdgeInsets.symmetric(horizontal: AppDimens.space),
        decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.space * 2),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "medium",
            style: AppTextStyles.smallerContent,
          ),
        ),
      );
    } else if (priority == 2) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimens.space),
        height: MediaQuery.of(context).size.height * 0.02,
        padding: EdgeInsets.symmetric(horizontal: AppDimens.space),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.space * 2),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "high",
            style: AppTextStyles.smallerContent,
          ),
        ),
      );
    }
  }

  _cancelButton({bool refresh = false}) {
    return AppButtonText(
      content: "cancel",
      bgColor: AppColors.primary,
      onPressed: () async {
        Navigator.pop(context);
        refresh ? await _editCollectionStore.refreshCardList() : () {};
      },
    );
  }

  String? _validatorFront(String? front) {
    if (front!.isEmpty) return "cannot be empty";
    if (front.length > 100) return "card can't have more than 100 characters";
  }

  String? _validatorBack(String? back) {
    if (back!.isEmpty) return "cannot be empty";
    if (back.length > 100) return "card cant have more than 100 characters";
  }

  String? _validatorNewFront(String? front) {
    if (front!.isEmpty) return "cannot be empty";
    if (front.length > 100) return "card can't have more than 100 characters";
  }

  String? _validatorNewBack(String? back) {
    if (back!.isEmpty) return "cannot be empty";
    if (back.length > 100) return "card cant have more than 100 characters";
  }

  void _errorModal({bool refresh = false, String errorMessage = ""}) {
    AppModal(
      context: context,
      title: errorMessage == ""
          ? "there was an error while trying to delete the card ${_editCollectionStore.errorMessage}"
          : errorMessage,
      actions: [
        AppButtonText(
          height: MediaQuery.of(context).size.height * 0.03,
          width: MediaQuery.of(context).size.width * 0.3,
          content: "ok",
          onPressed: () async {
            Navigator.pop(context);
            refresh ? await _editCollectionStore.refreshCardList() : () {};
          },
        ),
      ],
    );
  }

  _deleteSwapBg() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
          right: AppDimens.space,
          top: AppDimens.space,
          bottom: AppDimens.space),
      padding: EdgeInsets.all(AppDimens.space),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimens.space),
          bottomRight: Radius.circular(AppDimens.space),
        ),
      ),
      child: Icon(
        Icons.delete_rounded,
        color: AppColors.white,
      ),
    );
  }

  _showSnackBar(context, CardModel collectionCard, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text("card front: ${collectionCard.front} deleted"),
        action: SnackBarAction(
          label: "undo",
          textColor: AppColors.black,
          onPressed: () async {
            undo = true;
            await _editCollectionStore.insertDeletedCard(collectionCard);
            await _editCollectionStore.refreshCardList();
          },
        ),
      ),
    );
  }

  _modalCollection() {
    AppModal(
      context: context,
      title: "edit collection",
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInput(
              hintText: "new name",
              value: _editCollectionStore
                  .collectionService.selectedCollection.name,
              validator: _validatorFront,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onChange: (value) {
                _editCollectionStore.editCollectionModel.name = value;
              },
            ),
            SizedBox(height: AppDimens.space * 2),
            AppButtonIcon(
              bgColor: AppColors.red,
              icon: Icons.delete_forever_rounded,
              onPressed: () {
                AppModal(
                  context: context,
                  title: "delete collection",
                  content: Text(
                    "are you sure you want to delete the collection?",
                    style: AppTextStyles.textInput,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cancelButton(),
                        AppButtonIcon(
                          bgColor: AppColors.red,
                          icon: Icons.delete_forever_rounded,
                          onPressed: () async {
                            bool ret =
                                await _editCollectionStore.deleteCollection();
                            if (ret) {
                              AppModal(
                                context: context,
                                title: "deleted!",
                                actions: [
                                  AppButtonText(
                                    content: "ok",
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          Routes.home, (route) => false);
                                    },
                                  )
                                ],
                              );
                            } else {
                              _errorModal(
                                  errorMessage:
                                      "error while trying to delete collection ${_editCollectionStore.errorMessage}");
                            }
                          },
                        ),
                      ],
                    )
                  ],
                );
              },
            )
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
                bool ret = await _editCollectionStore.editCollection();
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (route) => false);

                if (ret) {
                  AppModal(context: context, title: "collection edited!");
                } else {
                  _errorModal(
                      errorMessage:
                          "error ${_editCollectionStore.errorMessage}");
                }
              },
            )
          ],
        )
      ],
    );
  }

  _cardCollectionModal(CardModel collectionCard) {
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
              value: collectionCard.front,
              validator: _validatorFront,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              nextFocus: _focusCardBack,
              onChange: (value) {
                _editCollectionStore.editCardModel.front = value;
              },
            ),
            SizedBox(height: AppDimens.space * 2),
            AppInput(
              hintText: "new back",
              value: collectionCard.back,
              validator: _validatorBack,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              focusNode: _focusCardBack,
              onChange: (value) {
                _editCollectionStore.editCardModel.back = value;
              },
            ),
            SizedBox(height: AppDimens.space * 2),
            AppButtonIcon(
              bgColor: AppColors.red,
              icon: Icons.delete_forever_rounded,
              onPressed: () {
                AppModal(
                  context: context,
                  title: "delete card",
                  content: Text(
                    "are you sure you want to delete the card?",
                    style: AppTextStyles.textInput,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cancelButton(),
                        AppButtonIcon(
                          bgColor: AppColors.red,
                          icon: Icons.delete_forever_rounded,
                          onPressed: () async {
                            bool ret = await _editCollectionStore
                                .deleteCard(collectionCard.id);
                            if (ret) {
                              AppModal(
                                context: context,
                                title: "deleted!",
                                actions: [
                                  AppButtonText(
                                    content: "ok",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            } else {
                              _errorModal();
                            }
                          },
                        )
                      ],
                    )
                  ],
                );
              },
            )
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
                if (_editCollectionStore.editCardModel.front == "") {
                  _editCollectionStore.editCardModel.front =
                      collectionCard.front;
                }
                if (_editCollectionStore.editCardModel.back == "") {
                  _editCollectionStore.editCardModel.front =
                      collectionCard.back;
                }

                bool ret =
                    await _editCollectionStore.editCard(collectionCard.id);
                Navigator.pop(context);

                if (ret) {
                  await _editCollectionStore.refreshCardList();
                  AppModal(context: context, title: "card edited!");
                } else {
                  _errorModal(
                      errorMessage:
                          "error ${_editCollectionStore.errorMessage}");
                }
              },
            )
          ],
        )
      ],
    );
  }
}
