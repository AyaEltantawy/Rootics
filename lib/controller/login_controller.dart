import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rootics_final/utils/api_endpoints.dart';

class LoginController extends GetxController{
  final storage = GetStorage();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      http.Response response = await http.post(
        Uri.parse(linkLogin),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: jsonEncode(<String, String>{
          'username': usernameController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        var token = responseBody['token'];
        print(token);
        //final SharedPreferences? prefs = await _pref;
        //final StorageService? storage = _storageService;

        //await prefs?.setString('token', token);
        await storage.write('token', token);
        usernameController.clear();
        passwordController.clear();
        //Get.offAll(MainWrapperPage());
        Get.offNamed('/main');
      } else {
        print(response.statusCode);
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      showSnackbar("Error", e.toString());
      print(e.toString());
    }
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 8,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }
}
