import 'dart:convert';
import 'package:front_moon_srs/app/authentication/data/models/dtos/sign_in.dto.dart';
import 'package:front_moon_srs/app/authentication/data/models/dtos/sign_up.dto.dart';
import 'package:front_moon_srs/app/authentication/data/models/user.model.dart';
import 'package:front_moon_srs/app/authentication/data/repositories/auth.repository.dart';
import 'package:front_moon_srs/app/authentication/data/sources/locar_storage.source.dart';
import 'package:mobx/mobx.dart';

part 'auth.service.g.dart';

class AuthService = _AuthServiceBase with _$AuthService;

abstract class _AuthServiceBase with Store {
  final AuthRepository accountRepository = AuthRepository();

  void reset() {
    LocalStorageSource.remove(LocalStorageKeys.access_token);
    LocalStorageSource.remove(LocalStorageKeys.expiration);
    LocalStorageSource.remove(LocalStorageKeys.user);

    setCurrentUser(UserModel());
  }

  @observable
  UserModel currentUser = UserModel();

  @action
  setCurrentUser(UserModel value) => currentUser = value;

  @action
  String? validateFormSignIn(SignInDto signInDTO) {
    signInDTO.username = signInDTO.username.trim();
    signInDTO.password = signInDTO.password.trim();

    if (signInDTO.username == "") {
      return "Apelido ou Email obrigatório";
    }

    if (signInDTO.password == "") {
      return "Password obrigatório";
    }

    return null;
  }

  Future<bool> signIn(SignInDto signInDto) async {
    final ssoDTO = await accountRepository.signIn(signInDto);

    LocalStorageSource.setString(
        LocalStorageKeys.access_token, ssoDTO.access_token);
    LocalStorageSource.setString(
        LocalStorageKeys.expiration, ssoDTO.expiration);
    LocalStorageSource.setString(LocalStorageKeys.user, ssoDTO.user);

    setCurrentUser(UserModel.fromJson(json.decode(ssoDTO.user)));

    return true;
  }

  Future<bool> signUp(SignUpDto signUpDto) async {
    bool ret = await accountRepository.signUp(signUpDto);

    // LocalStorageSource.setString(
    //     LocalStorageKeys.access_token, ssoDTO.access_token);
    // LocalStorageSource.setString(
    //     LocalStorageKeys.expiration, ssoDTO.expiration);

    // setCurrentUser(UserModel.fromJson(json.decode(ssoDTO.user)));

    return ret;
  }

  String? validateUsername(String username) {
    if (username == "") return "Apelido não pode ser vazio.";

    if (username.contains(" ")) return "Não é permitido espaços";

    return null;
  }
}
