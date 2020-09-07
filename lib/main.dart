import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tudodelivery/app/views/home-view.dart';
import 'package:tudodelivery/app/views/pedidos-view.dart';
import 'package:tudodelivery/app/views/perfil-view.dart';

import 'app/controllers/theme-controller.dart';
import 'app/views/splash-view.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ThemeController>(() => ThemeController());
  ThemeController.to.getThemeMode();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    theme: ThemeData.light().copyWith(primaryColor: Colors.orange),
    darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.black),
    themeMode: ThemeController.to.themeMode,
    getPages: [
      GetPage(name: '/', page: () => SplashView()),
      GetPage(name: '/home', page: () => HomeView()),
      GetPage(name: '/pedidos', page: () => PedidosView()),
      GetPage(name: '/perfil', page: () => PerfilView()),
    ],
  ));
}
