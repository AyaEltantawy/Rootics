import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/utils/api_endpoints.dart';
import 'package:rootics_final/view/main_wrapper_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  bool visiple1 = true;
  bool visiple2 = true;

  void changeVisiple1() {
    visiple1 = !visiple1;
    update();
  }

  void changeVisiple2() {
    visiple2 = !visiple2;
    update();
  }

  Future<void> register() async {
    try {
      http.Response response = await http.post(
        Uri.parse(linkRegister),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: jsonEncode(<String, String>{
          "email": emailController.text,
          "userName": userNameController.text,
          "password": passwordController.text,
          "confirmPassword": confirmPasswordController.text
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // var token = responseBody['token'];
        // print(token);
        //final SharedPreferences? prefs = await _pref;

        //await prefs?.setString('token', token);
        userNameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Get.off(MainWrapperPage());
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
