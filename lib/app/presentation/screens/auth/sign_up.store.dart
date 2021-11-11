import 'package:dio/dio.dart';
import 'package:front_moon_srs/app/authentication/data/models/dtos/sign_up.dto.dart';
import 'package:front_moon_srs/app/authentication/data/services/auth.service.dart';
import 'package:front_moon_srs/core/service_locator.dart';
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

  @observable
  bool isPasswordHidden = true;

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

  togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
  }

  String? validateUsername(String? username) {
    if (username!.isEmpty) return "cannot be empty";
    if (username.contains(RegExp(r'[A-Z]'))) {
      return "username needs at least one letter in uppercase";
    }
    if (username.length < 2) {
      return "username needs to have at lest 3 characters";
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) return "cannot be empty";
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "at least one letter in uppercase";
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "password needs at least one number";
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "password needs to have special character (@!#%)";
    }
    if (password.length < 3) {
      return "passwords needs to have at lest 3 characters";
    }

    return null;
  }

  String? validateConfirmPassword(String? password) {
    if (password!.isEmpty) return "cannot be empty";
    if (password != formSignUp.password)
      return "the password fields must be the same";

    return null;
  }

  String? validateEmail(String? email) {
    if (email!.isEmpty) return "cannot be empty";
    if (!email.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
      return "please enter an valid email";
    }

    return null;
  }
}
