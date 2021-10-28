import 'package:front_moon_srs/app/authentication/data/models/collection.model.dart';
import 'package:front_moon_srs/core/http_service.dart';

import '../sources/api.source.dart' as endpoints;

class CollectionRepository {
  Future<CollectionModel> getCollectionById(int collectionId) async {
    String url = endpoints.collection.getCollectionById;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "collectionId": collectionId,
    };

    final retCollection = await dio.get(url, queryParameters: params);

    return CollectionModel.fromJson(retCollection.data);
  }

  Future<List<CollectionModel>> listCollectionsByCurrentUserId() async {
    String url = endpoints.collection.listCollectionByCurrentUserId;

    final dio = HttpService.withAuthentication().instance;

    final retList = await dio.get(url);

    return CollectionModel.fromJsonList(retList.data);
  }

  Future<CollectionModel> createCollection(
      CollectionModel collectionModel) async {
    String url = endpoints.collection.createCollection;

    final dio = HttpService.withAuthentication().instance;

    final retCollection = await dio.post(url, data: collectionModel.toJson());

    return CollectionModel.fromJson(retCollection.data);
  }

  Future<CollectionModel> editCollection(
      int collectionId, CollectionModel collectionModel) async {
    String url = endpoints.collection.editCollection;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "collectionId": collectionId,
    };

    final retCollection = await dio.put(url,
        data: collectionModel.toJson(), queryParameters: params);

    return CollectionModel.fromJson(retCollection.data);
  }

  Future<bool> deleteCollection(int collectionId) async {
    String url = endpoints.collection.deleteCollection;

    final dio = HttpService.withAuthentication().instance;

    Map<String, dynamic> params = {
      "collectionId": collectionId,
    };

    final ret = await dio.delete(url, queryParameters: params);

    return ret.data;
  }
}
