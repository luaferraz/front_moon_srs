// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spaced_repetition.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SpacedRepetitionStore on _SpacedRepetitionStore, Store {
  final _$isLoadingAtom = Atom(name: '_SpacedRepetitionStore.isLoading');

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

  final _$errorMessageAtom = Atom(name: '_SpacedRepetitionStore.errorMessage');

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

  final _$cardModelAtom = Atom(name: '_SpacedRepetitionStore.cardModel');

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

  final _$collectionModelAtom =
      Atom(name: '_SpacedRepetitionStore.collectionModel');

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

  final _$isCardNullAtom = Atom(name: '_SpacedRepetitionStore.isCardNull');

  @override
  bool get isCardNull {
    _$isCardNullAtom.reportRead();
    return super.isCardNull;
  }

  @override
  set isCardNull(bool value) {
    _$isCardNullAtom.reportWrite(value, super.isCardNull, () {
      super.isCardNull = value;
    });
  }

  final _$editCardModelAtom =
      Atom(name: '_SpacedRepetitionStore.editCardModel');

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

  final _$_SpacedRepetitionStoreActionController =
      ActionController(name: '_SpacedRepetitionStore');

  @override
  dynamic _setLoading(bool value) {
    final _$actionInfo = _$_SpacedRepetitionStoreActionController.startAction(
        name: '_SpacedRepetitionStore._setLoading');
    try {
      return super._setLoading(value);
    } finally {
      _$_SpacedRepetitionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setErrorMessage(String value) {
    final _$actionInfo = _$_SpacedRepetitionStoreActionController.startAction(
        name: '_SpacedRepetitionStore._setErrorMessage');
    try {
      return super._setErrorMessage(value);
    } finally {
      _$_SpacedRepetitionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setCardModel(CardModel value) {
    final _$actionInfo = _$_SpacedRepetitionStoreActionController.startAction(
        name: '_SpacedRepetitionStore._setCardModel');
    try {
      return super._setCardModel(value);
    } finally {
      _$_SpacedRepetitionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
cardModel: ${cardModel},
collectionModel: ${collectionModel},
isCardNull: ${isCardNull},
editCardModel: ${editCardModel}
    ''';
  }
}
