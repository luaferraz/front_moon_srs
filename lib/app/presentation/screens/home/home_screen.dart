import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app/authentication/data/models/collection.model.dart';
import 'package:front_moon_srs/app/presentation/screens/home/home.store.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String route = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore _homeStore = HomeStore();

  @override
  void initState() {
    super.initState();

    setState(() {
      _homeStore.init(context);
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimens.space * 2),
          child: Column(
            children: [
              SizedBox(height: AppDimens.space * 2),
              Observer(
                builder: (_) => _collectionInfo(),
              ),
              Expanded(
                child: Observer(
                  builder: (_) => (AppLoading(
                    status: _homeStore.isLoading,
                    child: ListView(
                      children: [
                        _collectionHeader(),
                      ],
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        elevation: 10,
        onPressed: () {
          _createCollection();
        },
        child: const Icon(Icons.add, size: 30),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: AppBottomBar(
          showHome: false,
        ),
      ),
    );
  }

  _collectionInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "you have: ${_homeStore.myCollections.length.toString()} collection",
          style: AppTextStyles.textGreyd,
        ),
      ],
    );
  }

  _createCollection() {
    return AppModal(
      context: context,
      title: "collection",
      content: AppInput(
        hintText: "name",
        onChange: (value) {
          _homeStore.collectionModel.name = value;
        },
      ),
      actions: [
        AppButtonText(
          content: "create",
          onPressed: () async {
            Navigator.pop(context);
            bool ret = await _homeStore.createCollection();
            if (ret) {
              AppModal(
                context: context,
                title: "collection created",
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
              AppModal(
                context: context,
                title: _homeStore.errorMessage,
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
      ],
    );
  }

  _collectionHeader() {
    return Column(
      children: [
        SizedBox(height: AppDimens.space * 2),
        _collectionBody(),
      ],
    );
  }

  _collectionBody() {
    return Observer(
      builder: (_) => (Column(
        children: [
          (_homeStore.myCollections.isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _homeStore.myCollections.length,
                  itemBuilder: (context, index) {
                    return _card(_homeStore.myCollections[index], index);
                  },
                )
              : Column(
                  children: const [Text("nenhum")],
                ),
        ],
      )),
    );
  }

  _card(CollectionModel collectionModel, int index) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.loose,
      children: [
        Container(
          padding: EdgeInsets.all(AppDimens.space * 2),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.18,
          margin: EdgeInsets.only(bottom: AppDimens.space),
          decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(AppDimens.space * 2)),
          child: Column(
            children: [
              AppButtonText(
                bgColor: AppColors.primary,
                content: "start",
                onPressed: () {
                  _homeStore.collectionService
                      .setSelectedCollection(collectionModel);
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.spacedRepetition, (route) => false);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButtonIcon(
                    icon: Icons.edit,
                    iconColor: AppColors.black,
                    bgColor: AppColors.lightGrey,
                    width: MediaQuery.of(context).size.width * 0.14,
                    onPressed: () {
                      _homeStore.collectionService
                          .setSelectedCollection(collectionModel);
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.editCollection, (route) => true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 40,
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
                collectionModel.name,
                style: AppTextStyles.smallContentWhite,
              ),
              Row(
                children: [
                  Text(
                    collectionModel.cardQuantity.toString(),
                    style: AppTextStyles.smallContentWhite,
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
        ),
      ],
    );
  }
}
