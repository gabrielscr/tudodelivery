import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tudodelivery/app/domain/auth-result.dart';
import 'package:tudodelivery/app/domain/usuario.dart';
import 'package:tudodelivery/app/repositories/auth-repository.dart';
import 'package:tudodelivery/app/utils/route.dart';
import 'package:tudodelivery/app/utils/utils.dart';
import 'package:tudodelivery/app/utils/validators.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());

  AuthResult authResult = AuthResult();

  AuthRepository authRepository = AuthRepository();

  Rx<Usuario> usuario = Usuario().obs;

  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  RxBool carregando = false.obs;

  bool get isValidLogin =>
      Validators().validarEmail() == null &&
      Validators().validarSenha() == null;

  @override
  onInit() {
    limparDados();
    verificarLogin();
  }

  verificarLogin() async {
    goTo('/home');
    // final SharedPreferences prefs = await sharedPreferences;

    // var token = prefs.getString('token');

    // if (GetUtils.isNullOrBlank(token)) {
    //   goTo('login');
    // } else {
    //   usuario.value = await authRepository.obterUsuario();
    //   goTo('home-admin');
    // }
  }

  login() async {
    changeCarregando(true);

    final SharedPreferences prefs = await sharedPreferences;

    authResult = await authRepository
        .login({'Email': usuario.value.email, 'Senha': usuario.value.senha});

    if (authResult.authenticated) {
      await prefs.setString('token', authResult.accessToken);
      usuario.value = await authRepository.obterUsuario();
      goTo('home-admin');
    } else {
      exibirSnackErro('Usuário ou senha inválidos');
    }

    changeCarregando(false);
  }

  logoff() async {
    final SharedPreferences prefs = await sharedPreferences;
    prefs.remove('token');
    goToAll('login');
  }

  changeCarregando(bool value) {
    carregando.value = value;
  }

  limparDados() {
    usuario.value.email = null;
    usuario.value.senha = null;
  }
}
