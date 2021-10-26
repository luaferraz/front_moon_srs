import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/data/models/card.model.dart';
import 'package:front_moon_srs/screens/collection/edit_collection.store.dart';
import 'package:front_moon_srs/shared/themes/app_colors.dart';
import 'package:front_moon_srs/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/shared/widgets/app_bottom_bar.dart';
import 'package:front_moon_srs/shared/widgets/app_button_text.dart';
import 'package:front_moon_srs/shared/widgets/app_dialog.dart';
import 'package:front_moon_srs/shared/widgets/app_input.dart';
import 'package:front_moon_srs/shared/widgets/app_loading.dart';
import 'package:front_moon_srs/shared/widgets/app_top_bar.dart';

class EditCollectionScreen extends StatefulWidget {
  const EditCollectionScreen({Key? key}) : super(key: key);

  static const String route = "editCollection";

  @override
  _EditCollectionScreenState createState() => _EditCollectionScreenState();
}

class _EditCollectionScreenState extends State<EditCollectionScreen> {
  final EditCollectionStore _editCollectionStore = EditCollectionStore();

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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
        elevation: 10,
        onPressed: () {
          _createCard();
        },
        child: const Icon(Icons.add, size: 30),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.white,
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
          Text(
            _editCollectionStore.collectionService.selectedCollection.name,
            style: AppTextStyles.smallContentWhite,
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
              )
            ],
          ),
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
        content: Text("card ** front: ${collectionCard.front} ** deleted"),
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
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimens.space * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _cardContentLine(
                        title: "front: ", content: collectionCard.front),
                    SizedBox(height: AppDimens.space * 0.5),
                    _cardContentLine(
                        title: "back: ", content: collectionCard.back),
                    SizedBox(height: AppDimens.space * 0.5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("priority: ", style: AppTextStyles.textPrimary),
                        _cardPriority(priority: collectionCard.priority),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    bool ret = await _editCollectionStore
                        .deleteCard(collectionCard.id);

                    if (ret) {
                      AppModal(
                        context: context,
                        title: "are you sure you want to delete the card?",
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppButtonText(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                width: MediaQuery.of(context).size.width * 0.3,
                                content: "cancel",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              AppButtonText(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                width: MediaQuery.of(context).size.width * 0.3,
                                content: "delete",
                                bgColor: AppColors.red,
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await _editCollectionStore
                                      .deleteCard(collectionCard.id);
                                  await _editCollectionStore.refreshCardList();
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      AppModal(
                        context: context,
                        title:
                            "there was an error while trying to delete the card",
                        actions: [
                          AppButtonText(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.3,
                            content: "ok",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    }
                  },
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: AppColors.red,
                    size: MediaQuery.of(context).size.height * 0.05,
                  ),
                )
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppInput(
              hintText: "front",
              onChange: (value) {
                _editCollectionStore.cardModel.front = value;
              },
            ),
            SizedBox(height: AppDimens.space),
            AppInput(
              hintText: "back",
              onChange: (value) {
                _editCollectionStore.cardModel.back = value;
              },
            ),
          ],
        ),
        actions: [
          AppButtonText(
            content: "create",
            onPressed: () async {
              Navigator.pop(context);
              bool ret = await _editCollectionStore.createCard();

              if (ret) {
                AppModal(
                  context: context,
                  title: "card created",
                  actions: [
                    AppButtonText(
                      content: "cancel",
                      onPressed: () async {
                        await _editCollectionStore.refreshCardList();
                        Navigator.pop(context);
                      },
                    ),
                    AppButtonText(
                      content: "create new",
                      onPressed: () async {
                        await _editCollectionStore.refreshCardList();
                        Navigator.pop(context);
                        _createCard();
                      },
                    ),
                  ],
                );
              } else {
                AppModal(
                  context: context,
                  title: _editCollectionStore.errorMessage,
                  actions: [
                    AppButtonText(
                      content: "ok",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ]);
  }

  _cardContentLine({String title = "", String content = ""}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.textPrimary,
        ),
        Text(
          content,
          style: AppTextStyles.textGreyd,
        ),
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
            style: AppTextStyles.smallerContentWhite,
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
            style: AppTextStyles.smallerContentWhite,
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
            style: AppTextStyles.smallerContentWhite,
          ),
        ),
      );
    }
  }
}
