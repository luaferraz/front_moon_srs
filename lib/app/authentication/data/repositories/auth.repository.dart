import 'package:front_moon_srs/app/authentication/data/models/dtos/sign_in.dto.dart';
import 'package:front_moon_srs/app/authentication/data/models/dtos/sign_up.dto.dart';
import 'package:front_moon_srs/app/authentication/data/models/dtos/sso.dto.dart';
import 'package:front_moon_srs/core/http_service.dart';

import '../sources/api.source.dart' as endpoints;

class AuthRepository {
  Future<SsoDTO> signIn(SignInDto signInDto) async {
    String url = endpoints.authentication.signIn;

    final dio = HttpService().instance;

    final retSignIn = await dio.post(url, data: signInDto.toJson());

    return SsoDTO.fromJson(retSignIn.data);
  }

  Future<bool> signUp(SignUpDto signUpDto) async {
    String url = endpoints.authentication.signUp;

    final dio = HttpService().instance;

    final retSignUp = await dio.post(url, data: signUpDto.toJson());

    return true;
  }
}
