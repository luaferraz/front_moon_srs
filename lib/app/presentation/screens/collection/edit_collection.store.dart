import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/authentication/data/models/card.model.dart';
import 'package:front_moon_srs/app/authentication/data/models/collection.model.dart';
import 'package:front_moon_srs/app/authentication/data/services/card.service.dart';
import 'package:front_moon_srs/app/authentication/data/services/collection.service.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:mobx/mobx.dart';

part 'edit_collection.store.g.dart';

class EditCollectionStore = _EditCollectionStore with _$EditCollectionStore;

abstract class _EditCollectionStore with Store {
  final collectionService = serviceLocator<CollectionService>();
  final cardService = serviceLocator<CardService>();

  @observable
  bool isLoading = false;

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
  CardModel editCardModel = CardModel();

  @observable
  CollectionModel selectedCollection = CollectionModel();

  @observable
  CollectionModel editCollectionModel = CollectionModel();

  Future<bool> init(BuildContext context) async {
    return await fetchData();
  }

  Future<bool> fetchData() async {
    try {
      _setLoading(true);
      selectedCollection = collectionService.selectedCollection;
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

  Future<bool> createCard() async {
    try {
      _setLoading(true);

      await cardService.createCard(cardModel, selectedCollection.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> editCard(int cardId) async {
    try {
      _setLoading(true);

      await cardService.editCard(cardId, editCardModel);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> editCollection() async {
    try {
      _setLoading(true);

      await collectionService.editCollection(
          selectedCollection.id, editCollectionModel);

      await collectionService.updateSelectedCollection();

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteCollection() async {
    try {
      _setLoading(true);

      await collectionService.deleteCollection(selectedCollection.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> insertDeletedCard(CardModel collectionCard) async {
    try {
      _setLoading(true);

      await cardService.createCard(collectionCard, selectedCollection.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
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
