import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_moon_srs/app/authentication/data/models/card.model.dart';
import 'package:front_moon_srs/app/authentication/data/models/collection.model.dart';
import 'package:front_moon_srs/app/authentication/data/services/card.service.dart';
import 'package:front_moon_srs/app/authentication/data/services/collection.service.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:mobx/mobx.dart';

part 'spaced_repetition.store.g.dart';

class SpacedRepetitionStore = _SpacedRepetitionStore
    with _$SpacedRepetitionStore;

abstract class _SpacedRepetitionStore with Store {
  final cardService = serviceLocator<CardService>();
  final collectionService = serviceLocator<CollectionService>();

  @observable
  bool isLoading = false;

  @action
  _setLoading(bool value) => isLoading = value;

  @observable
  String errorMessage = "";

  @action
  _setErrorMessage(String value) => errorMessage = value;

  @observable
  CardModel cardModel = CardModel();

  @action
  _setCardModel(CardModel value) => cardModel = value;

  @observable
  CollectionModel collectionModel = CollectionModel();

  @observable
  bool isCardNull = false;

  @observable
  CardModel editCardModel = CardModel();

  Future<bool> init(BuildContext context) async {
    return await fetchData();
  }

  Future<bool> fetchData() async {
    try {
      _setLoading(true);

      collectionModel = collectionService.selectedCollection;

      _setCardModel(await cardService.getCardByReleaseDate(collectionModel.id));

      print(collectionModel.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      isCardNull = true;
      print(isCardNull);
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> getCardByReleaseDate() async {
    try {
      _setLoading(true);

      _setCardModel(await cardService.getCardByReleaseDate(collectionModel.id));

      await cardService.getCardByReleaseDate(collectionModel.id);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      isCardNull = true;
      _setErrorMessage("Oops! Algo deu errado, tente novamente.");

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> answerCard(int priority) async {
    try {
      _setLoading(true);

      await cardService.answerCard(cardModel.id, priority);

      return true;
    } on DioError catch (e) {
      print("Error:  $e");
      isCardNull = true;
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
}
