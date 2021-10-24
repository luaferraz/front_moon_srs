class _Authentication {
  final signIn = "/auth/sign-in";
}

class _Collection {
  final listCollectionByCurrentUserId =
      "/collection/list-collections-by-current-user-id";
  final createCollection = "/collection/create-collection";
}

class _Card {
  final listCardsByCollectionId =
      "/card/list-cards-by-collection-id?collectionId=1";
  final createCard = "/card/create-card";
  final getCardByReleaseDate = "/card/get-card-by-release-date";
  final answerCard = "/card/answer-card";
}

final authentication = _Authentication();
final collection = _Collection();
final card = _Card();
