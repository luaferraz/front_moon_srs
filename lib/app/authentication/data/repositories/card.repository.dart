import 'package:front_moon_srs/app/authentication/data/models/card.model.dart';
import 'package:front_moon_srs/core/http_service.dart';

import '../sources/api.source.dart' as endpoints;

class CardRepository {
  Future<List<CardModel>> listCardsByCollectionId(int collectionId) async {
    String url = endpoints.card.listCardsByCollectionId;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "collectionId": collectionId,
    };

    final retList = await dio.get(url, queryParameters: params);

    return CardModel.fromJsonList(retList.data);
  }

  Future<CardModel> createCard(CardModel cardModel, int collectionId) async {
    String url = endpoints.card.createCard;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "collectionId": collectionId,
    };

    final ret =
        await dio.post(url, queryParameters: params, data: cardModel.toJson());

    return CardModel.fromJson(ret.data);
  }

  Future<CardModel> getCardByReleaseDate(int collectionId) async {
    String url = endpoints.card.getCardByReleaseDate;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "collectionId": collectionId,
    };

    final ret = await dio.get(url, queryParameters: params);

    return CardModel.fromJson(ret.data);
  }

  Future<CardModel> answerCard(int cardId, int priority) async {
    String url = endpoints.card.answerCard;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "cardId": cardId,
      "priority": priority,
    };

    final ret = await dio.put(url, queryParameters: params);

    return CardModel.fromJson(ret.data);
  }

  Future<bool> deleteCard(int cardId) async {
    String url = endpoints.card.deleteCard;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "cardId": cardId,
    };

    final ret = await dio.delete(url, queryParameters: params);

    return ret.data;
  }
}
