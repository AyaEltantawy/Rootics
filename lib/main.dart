import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rootics_final/view/home_page.dart';
import 'package:rootics_final/view/login_page.dart';
import 'package:rootics_final/view/main_wrapper_page.dart';
import 'package:rootics_final/view/welcome_page.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => AuthCheck()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/main', page: () => MainWrapperPage()),
        GetPage(name: '/home', page: () => HomePage()),

      ],
      home: welcomePage(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    String? token = storage.read('token');
    if (token != null) {
      Future.delayed(Duration.zero, () => Get.offNamed('/main'));
    } else {
      Future.delayed(Duration.zero, () => Get.offNamed('/login'));
    }
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
