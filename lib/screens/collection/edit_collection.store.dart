import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:front_moon_srs/data/models/card.model.dart';
import 'package:front_moon_srs/data/models/collection.model.dart';
import 'package:front_moon_srs/data/services/card.service.dart';
import 'package:front_moon_srs/data/services/collection.service.dart';
import 'package:mobx/mobx.dart';
part 'edit_collection.store.g.dart';

class EditCollectionStore = _EditCollectionStore with _$EditCollectionStore;

abstract class _EditCollectionStore with Store {
  final collectionService = serviceLocator<CollectionService>();
  final cardService = serviceLocator<CardService>();

  @observable
  bool isLoading = false;

  @action
  setLoading(bool value) => isLoading = value;

  @action
  _setLoading(bool value) => isLoading = value;

  @observable
  String errorMessage = "";

  @action
  _setErrorMessage(String value) => errorMessage = value;

  @observable
  List<CardModel> collectionCards = [];

  @action
  _setCollectionCards(List<CardModel> value) => collectionCards = value;

  @observable
  CardModel cardModel = CardModel();

  @observable
  CollectionModel selectedCollection = CollectionModel();

  Future<bool> init(BuildContext context) async {
    return await fetchData();
  }

  Future<bool> fetchData() async {
    try {
      setLoading(true);
      selectedCollection = collectionService.selectedCollection;
      print(selectedCollection.id);
      collectionCards =
          await cardService.listCardByCollectionId(selectedCollection.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> createCard() async {
    try {
      setLoading(true);

      await cardService.createCard(cardModel, selectedCollection.id);

      // collectionCards = await cardService.listCardByCollectionId(collectionService.selectedCollection.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> insertDeletedCard(CardModel collectionCard) async {
    try {
      setLoading(true);

      await cardService.createCard(collectionCard, selectedCollection.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> deleteCard(int cardId) async {
    try {
      _setLoading(true);

      await cardService.deleteCard(cardId);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> refreshCardList() async {
    try {
      _setLoading(true);

      collectionCards =
          await cardService.listCardByCollectionId(selectedCollection.id);

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
