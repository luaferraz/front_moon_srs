import 'package:front_moon_srs/data/models/collection.model.dart';
import 'package:front_moon_srs/data/repositories/collection.repository.dart';
import 'package:mobx/mobx.dart';

part 'collection.service.g.dart';

class CollectionService = _CollectionServiceBase with _$CollectionService;

abstract class _CollectionServiceBase with Store {
  final CollectionRepository collectionRepository = CollectionRepository();

  @observable
  CollectionModel selectedCollection = CollectionModel();

  @action
  setSelectedCollection(CollectionModel value) => selectedCollection = value;

  @action
  void reset() {
    setSelectedCollection(CollectionModel());
  }

  Future<List<CollectionModel>> listCollectionsByCurrentUserId() async {
    return await collectionRepository.listCollectionsByCurrentUserId();
  }

  Future<CollectionModel> createCollection(
      CollectionModel collectionModel) async {
    return await collectionRepository.createCollection(collectionModel);
  }
}
