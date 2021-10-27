// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$isLoadingAtom = Atom(name: '_HomeStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_HomeStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$myCollectionsAtom = Atom(name: '_HomeStore.myCollections');

  @override
  List<CollectionModel> get myCollections {
    _$myCollectionsAtom.reportRead();
    return super.myCollections;
  }

  @override
  set myCollections(List<CollectionModel> value) {
    _$myCollectionsAtom.reportWrite(value, super.myCollections, () {
      super.myCollections = value;
    });
  }

  final _$collectionModelAtom = Atom(name: '_HomeStore.collectionModel');

  @override
  CollectionModel get collectionModel {
    _$collectionModelAtom.reportRead();
    return super.collectionModel;
  }

  @override
  set collectionModel(CollectionModel value) {
    _$collectionModelAtom.reportWrite(value, super.collectionModel, () {
      super.collectionModel = value;
    });
  }

  final _$collectionCardsAtom = Atom(name: '_HomeStore.collectionCards');

  @override
  List<CardModel> get collectionCards {
    _$collectionCardsAtom.reportRead();
    return super.collectionCards;
  }

  @override
  set collectionCards(List<CardModel> value) {
    _$collectionCardsAtom.reportWrite(value, super.collectionCards, () {
      super.collectionCards = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  dynamic _setLoading(bool value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore._setLoading');
    try {
      return super._setLoading(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setErrorMessage(String value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore._setErrorMessage');
    try {
      return super._setErrorMessage(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setMyCollections(List<CollectionModel> value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore._setMyCollections');
    try {
      return super._setMyCollections(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setCollectionCards(List<CardModel> value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore._setCollectionCards');
    try {
      return super._setCollectionCards(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
myCollections: ${myCollections},
collectionModel: ${collectionModel},
collectionCards: ${collectionCards}
    ''';
  }
}
