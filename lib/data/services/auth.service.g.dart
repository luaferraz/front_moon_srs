// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthService on _AuthServiceBase, Store {
  final _$currentUserAtom = Atom(name: '_AuthServiceBase.currentUser');

  @override
  UserModel get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserModel value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$_AuthServiceBaseActionController =
      ActionController(name: '_AuthServiceBase');

  @override
  dynamic setCurrentUser(UserModel value) {
    final _$actionInfo = _$_AuthServiceBaseActionController.startAction(
        name: '_AuthServiceBase.setCurrentUser');
    try {
      return super.setCurrentUser(value);
    } finally {
      _$_AuthServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validateFormSignIn(SignInDto signInDTO) {
    final _$actionInfo = _$_AuthServiceBaseActionController.startAction(
        name: '_AuthServiceBase.validateFormSignIn');
    try {
      return super.validateFormSignIn(signInDTO);
    } finally {
      _$_AuthServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser}
    ''';
  }
}
