// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_collection.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditCollectionStore on _EditCollectionStore, Store {
  final _$isLoadingAtom = Atom(name: '_EditCollectionStore.isLoading');

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

  final _$errorMessageAtom = Atom(name: '_EditCollectionStore.errorMessage');

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

  final _$collectionCardsAtom =
      Atom(name: '_EditCollectionStore.collectionCards');

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

  final _$cardModelAtom = Atom(name: '_EditCollectionStore.cardModel');

  @override
  CardModel get cardModel {
    _$cardModelAtom.reportRead();
    return super.cardModel;
  }

  @override
  set cardModel(CardModel value) {
    _$cardModelAtom.reportWrite(value, super.cardModel, () {
      super.cardModel = value;
    });
  }

  final _$editCardModelAtom = Atom(name: '_EditCollectionStore.editCardModel');

  @override
  CardModel get editCardModel {
    _$editCardModelAtom.reportRead();
    return super.editCardModel;
  }

  @override
  set editCardModel(CardModel value) {
    _$editCardModelAtom.reportWrite(value, super.editCardModel, () {
      super.editCardModel = value;
    });
  }

  final _$selectedCollectionAtom =
      Atom(name: '_EditCollectionStore.selectedCollection');

  @override
  CollectionModel get selectedCollection {
    _$selectedCollectionAtom.reportRead();
    return super.selectedCollection;
  }

  @override
  set selectedCollection(CollectionModel value) {
    _$selectedCollectionAtom.reportWrite(value, super.selectedCollection, () {
      super.selectedCollection = value;
    });
  }

  final _$editCollectionModelAtom =
      Atom(name: '_EditCollectionStore.editCollectionModel');

  @override
  CollectionModel get editCollectionModel {
    _$editCollectionModelAtom.reportRead();
    return super.editCollectionModel;
  }

  @override
  set editCollectionModel(CollectionModel value) {
    _$editCollectionModelAtom.reportWrite(value, super.editCollectionModel, () {
      super.editCollectionModel = value;
    });
  }

  final _$_EditCollectionStoreActionController =
      ActionController(name: '_EditCollectionStore');

  @override
  dynamic _setLoading(bool value) {
    final _$actionInfo = _$_EditCollectionStoreActionController.startAction(
        name: '_EditCollectionStore._setLoading');
    try {
      return super._setLoading(value);
    } finally {
      _$_EditCollectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setErrorMessage(String value) {
    final _$actionInfo = _$_EditCollectionStoreActionController.startAction(
        name: '_EditCollectionStore._setErrorMessage');
    try {
      return super._setErrorMessage(value);
    } finally {
      _$_EditCollectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setCollectionCards(List<CardModel> value) {
    final _$actionInfo = _$_EditCollectionStoreActionController.startAction(
        name: '_EditCollectionStore._setCollectionCards');
    try {
      return super._setCollectionCards(value);
    } finally {
      _$_EditCollectionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
collectionCards: ${collectionCards},
cardModel: ${cardModel},
editCardModel: ${editCardModel},
selectedCollection: ${selectedCollection},
editCollectionModel: ${editCollectionModel}
    ''';
  }
}
