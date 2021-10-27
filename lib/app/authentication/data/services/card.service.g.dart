// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardService on _CardServiceBase, Store {
  final _$selectedCardAtom = Atom(name: '_CardServiceBase.selectedCard');

  @override
  CardModel get selectedCard {
    _$selectedCardAtom.reportRead();
    return super.selectedCard;
  }

  @override
  set selectedCard(CardModel value) {
    _$selectedCardAtom.reportWrite(value, super.selectedCard, () {
      super.selectedCard = value;
    });
  }

  final _$_CardServiceBaseActionController =
      ActionController(name: '_CardServiceBase');

  @override
  dynamic setSelectedCard(CardModel value) {
    final _$actionInfo = _$_CardServiceBaseActionController.startAction(
        name: '_CardServiceBase.setSelectedCard');
    try {
      return super.setSelectedCard(value);
    } finally {
      _$_CardServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_CardServiceBaseActionController.startAction(
        name: '_CardServiceBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CardServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCard: ${selectedCard}
    ''';
  }
}
