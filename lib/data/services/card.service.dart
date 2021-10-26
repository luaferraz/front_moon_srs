import 'package:front_moon_srs/data/models/card.model.dart';
import 'package:front_moon_srs/data/repositories/card.repository.dart';
import 'package:mobx/mobx.dart';

part 'card.service.g.dart';

class CardService = _CardServiceBase with _$CardService;

abstract class _CardServiceBase with Store {
  final CardRepository cardRepository = CardRepository();

  @observable
  CardModel selectedCard = CardModel();

  @action
  setSelectedCard(CardModel value) => selectedCard = value;

  @action
  void reset() {
    setSelectedCard(CardModel());
  }

  Future<List<CardModel>> listCardByCollectionId(int cardId) async {
    return await cardRepository.listCardsByCollectionId(cardId);
  }

  Future<CardModel> createCard(CardModel cardModel, int collectionId) async {
    return await cardRepository.createCard(cardModel, collectionId);
  }

  Future<CardModel> getCardByReleaseDate(int collectionId) async {
    return await cardRepository.getCardByReleaseDate(collectionId);
  }

  Future<CardModel> answerCard(int cardId, int priority) async {
    return await cardRepository.answerCard(cardId, priority);
  }

  Future<bool> deleteCard(int cardId) async {
    return await cardRepository.deleteCard(cardId);
  }
}
