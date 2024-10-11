import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/controller/login_controller.dart';
import 'package:rootics_final/custom_widgets/submitBtn.dart';
import 'package:rootics_final/custom_widgets/txtFormField.dart';
import 'package:rootics_final/theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formState = GlobalKey();
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: formState,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: screenHeitht,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "lib/assets/images/Rgister_background.jfif"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: screenWidth * 0.1,
                bottom: screenWidth * 0.2,
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: screenHeitht * 0.7,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: AppColors().lightGreen,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 8,
                        color: AppColors().darkGreen,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                //top: screenHeitht*0.0001,
                bottom: screenHeitht * 0.5,
                left: screenWidth * 0.22,
                child: Container(
                    height: screenHeitht * 0.6,
                    width: screenWidth * 0.6,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("lib/assets/images/logo.png")))),
              ),
              Positioned(
                right: screenWidth * 0.175,
                bottom: screenWidth * 0.3,
                child: Container(
                  //color: Colors.amber,
                  height: screenHeitht * 0.45,
                  width: screenWidth * 0.65,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          CustomTextForm(
                            lable: "الاسم",
                            myController: loginController.usernameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل فارغ";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextForm(
                            lable: 'كلمة المرور',
                            myController: loginController.passwordController,
                            keyboardType: TextInputType.text,
                            // suffix: IconButton(
                            //   onPressed: () => loginController.changeVisiple(),
                            //   icon: Icon(
                            //     loginController.visiple.value
                            //         ? Icons.visibility
                            //         : Icons.visibility_off,
                            //   ),
                            // ),
                            // obscureText: loginController.visiple.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل فارغ";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SubmitBtn(onTap: () => loginController.login(), text: "تسجيل الدخول"),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "ليس لديك حساب ؟",
                                style: TextStyle(fontSize: 17),
                              ),
                              InkWell(
                                  child: Text(
                                    '  سجل الان',
                                    style: TextStyle(
                                        color: AppColors().darkGreen3,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  //onTap: () => Get.off(const RegisterPage())
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}