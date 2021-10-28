import 'package:front_moon_srs/app/authentication/data/models/collection.model.dart';
import 'package:front_moon_srs/app/authentication/data/repositories/collection.repository.dart';
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

  Future<void> updateSelectedCollection() async {
    if (selectedCollection.id != null) return;

    CollectionModel getCollection =
        await getCollectionById(selectedCollection.id);
    setSelectedCollection(getCollection);
  }

  Future<CollectionModel> getCollectionById(int collectionId) async {
    return await collectionRepository.getCollectionById(collectionId);
  }

  Future<List<CollectionModel>> listCollectionsByCurrentUserId() async {
    return await collectionRepository.listCollectionsByCurrentUserId();
  }

  Future<CollectionModel> createCollection(
      CollectionModel collectionModel) async {
    return await collectionRepository.createCollection(collectionModel);
  }

  Future<CollectionModel> editCollection(
      int collectionId, CollectionModel collectionModel) async {
    return await collectionRepository.editCollection(
        collectionId, collectionModel);
  }

  Future<bool> deleteCollection(int collectionId) async {
    return await collectionRepository.deleteCollection(collectionId);
  }
}
