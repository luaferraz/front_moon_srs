import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/authentication/data/models/card.model.dart';
import 'package:front_moon_srs/app/authentication/data/models/collection.model.dart';
import 'package:front_moon_srs/app/authentication/data/services/auth.service.dart';
import 'package:front_moon_srs/app/authentication/data/services/card.service.dart';
import 'package:front_moon_srs/app/authentication/data/services/collection.service.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:mobx/mobx.dart';
part 'home.store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final collectionService = serviceLocator<CollectionService>();
  final cardService = serviceLocator<CardService>();
  final authService = serviceLocator<AuthService>();

  @observable
  bool isLoading = false;

  @action
  _setLoading(bool value) => isLoading = value;

  @observable
  String errorMessage = "";

  @action
  _setErrorMessage(String value) => errorMessage = value;

  @observable
  List<CollectionModel> myCollections = [];

  @action
  _setMyCollections(List<CollectionModel> value) => myCollections = value;

  @observable
  CollectionModel collectionModel = CollectionModel();

  @observable
  List<CardModel> collectionCards = [];

  @action
  _setCollectionCards(List<CardModel> value) => collectionCards = value;

  Future<bool> init(BuildContext context) async {
    print(isLoading);
    return await fetchData();
  }

  Future<bool> fetchData() async {
    try {
      _setLoading(true);
      _setMyCollections(myCollections =
          await collectionService.listCollectionsByCurrentUserId());

      print(myCollections.length);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createCollection() async {
    try {
      _setLoading(true);

      await collectionService.createCollection(collectionModel);

      myCollections = await collectionService.listCollectionsByCurrentUserId();

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }
}
