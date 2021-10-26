import 'package:dio/dio.dart';
import 'package:front_moon_srs/core/service_locator.dart';
import 'package:front_moon_srs/data/models/dtos/sign_up.dto.dart';
import 'package:front_moon_srs/data/services/auth.service.dart';
import 'package:mobx/mobx.dart';

part 'sign_up.store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
  final authService = serviceLocator<AuthService>();

  @observable
  bool isLoading = false;

  @action
  setLoading(bool value) => isLoading = value;

  @observable
  String errorMessage = "";

  @action
  _setErrorMessage(String value) => errorMessage = value;

  @observable
  SignUpDto formSignUp = SignUpDto();

  @action
  setFormSignIn(SignUpDto value) => formSignUp = value;

  Future<bool> signUp() async {
    setLoading(true);

    try {
      await authService.signUp(formSignUp);

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
