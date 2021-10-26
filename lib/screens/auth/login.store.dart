import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:front_moon_srs/data/models/dtos/sign_in.dto.dart';
import 'package:front_moon_srs/data/services/auth.service.dart';
import 'package:front_moon_srs/data/services/card.service.dart';
import 'package:front_moon_srs/data/services/collection.service.dart';
import 'package:mobx/mobx.dart';

part 'login.store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final authService = serviceLocator<AuthService>();
  final cardService = serviceLocator<CardService>();
  final collectionService = serviceLocator<CollectionService>();

  @observable
  bool isLoading = false;

  @action
  setLoading(bool value) => isLoading = value;

  @observable
  String errorMessage = "";

  @action
  _setErrorMessage(String value) => errorMessage = value;

  @observable
  SignInDto formSignIn = SignInDto();

  @action
  setFormSignIn(SignInDto value) => formSignIn = value;

  Future<void> init(BuildContext context) async {
    try {
      setLoading(true);

      authService.reset();
      cardService.reset();
      collectionService.reset();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signIn() async {
    setLoading(true);

    try {
      if (authService.validateFormSignIn(formSignIn) != null) {
        _setErrorMessage(authService.validateFormSignIn(formSignIn)!);

        return false;
      }

      await authService.signIn(formSignIn);

      return true;
    } on DioError catch (e) {
      _setErrorMessage(e.message);

      if (e.response != null) {
        _setErrorMessage(e.message);
      } else {
        _setErrorMessage(e.message);
      }

      return false;
    } finally {
      setLoading(false);
    }
  }
}
