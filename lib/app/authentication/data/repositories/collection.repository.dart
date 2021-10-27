import 'package:front_moon_srs/app/authentication/data/models/collection.model.dart';
import 'package:front_moon_srs/core/http_service.dart';

import '../sources/api.source.dart' as endpoints;

class CollectionRepository {
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
}
