// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CollectionService on _CollectionServiceBase, Store {
  final _$selectedCollectionAtom =
      Atom(name: '_CollectionServiceBase.selectedCollection');

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

  final _$_CollectionServiceBaseActionController =
      ActionController(name: '_CollectionServiceBase');

  @override
  dynamic setSelectedCollection(CollectionModel value) {
    final _$actionInfo = _$_CollectionServiceBaseActionController.startAction(
        name: '_CollectionServiceBase.setSelectedCollection');
    try {
      return super.setSelectedCollection(value);
    } finally {
      _$_CollectionServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CollectionServiceBaseActionController.startAction(
        name: '_CollectionServiceBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CollectionServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCollection: ${selectedCollection}
    ''';
  }
}
