import 'package:front_moon_srs/core/dio_client.dart';
import 'package:front_moon_srs/data/models/dtos/sign_in.dto.dart';
import 'package:front_moon_srs/data/models/dtos/sso.dto.dart';
import '../sources/api.source.dart' as endpoints;

class AuthRepository {
  Future<SsoDTO> signIn(SignInDto signInDto) async {
    String url = endpoints.authentication.signIn;

    final dio = DioClient().instance;

    final retSignIn = await dio.post(url, data: signInDto.toJson());

    return SsoDTO.fromJson(retSignIn.data);
  }
}
