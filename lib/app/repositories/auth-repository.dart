import 'package:dio/dio.dart';
import 'package:tudodelivery/app/domain/auth-result.dart';
import 'package:tudodelivery/app/domain/resultado.dart';
import 'package:tudodelivery/app/domain/usuario.dart';
import 'package:tudodelivery/app/utils/route.dart';

import 'api-repository.dart';

class AuthRepository {
  ApiRepository apiRepository = ApiRepository();

  Future<AuthResult> login(params) async {
    try {
      var response = await apiRepository.post('Auth/Autenticar', params);

      AuthResult auth = AuthResult.fromJson(response.data);

      return auth;
    } on DioError catch (e) {
      print(e.response.data);
      return null;
    }
  }

  Future<Resultado> cadastrar(params) async {
    var response = await apiRepository.post('Auth/Cadastrar', params);

    Resultado resultado = Resultado.fromJson(response.data);

    return resultado;
  }

  Future<Usuario> obterUsuario() async {
    var response = await apiRepository.get('Auth/ObterUsuario', {});

    if (response.statusCode == 200)
      return Usuario.fromJson(response.data);
    else {
      goTo('login');
      return null;
    }
  }
}
