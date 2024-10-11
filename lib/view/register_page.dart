import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/controller/register_controller.dart';
import 'package:rootics_final/custom_widgets/submitBtn.dart';
import 'package:rootics_final/custom_widgets/txtFormField.dart';
import 'package:rootics_final/theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formState = GlobalKey();
  RegisterController registerController = Get.put(RegisterController());

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
                bottom: screenWidth * 0.1,
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: screenHeitht * 0.8,
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
                bottom: screenWidth * 0.2,
                child: Container(
                  //color: Colors.amber,
                  height: screenHeitht * 0.5,
                  width: screenWidth * 0.65,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextForm(
                            lable: "الاسم",
                            myController: registerController.userNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل فارغ";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextForm(
                            lable: 'البريد الالكتروني',
                            myController: registerController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل فارغ";
                              }
                              if (value.contains('@') == false) {
                                return 'الرجاء ادخال بريد الكتروني صحيح';
                              }
                              if (value.contains('.com') == false) {
                                return 'الرجاء ادخال بريد الكتروني صحيح';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextForm(
                            lable: 'كلمة المرور',
                            myController: registerController.passwordController,
                            suffix: IconButton(
                              onPressed: () => registerController.changeVisiple1(),
                              icon: Icon(
                                registerController.visiple1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            obscureText: registerController.visiple1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل فارغ";
                              }
                              if (value.length < 6) {
                                return "لايمكن ان تكون كلمة المرور اقل من 8 حروف";
                              }
                              bool hasSymbol = value
                                  .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                              bool hasNumber = value.contains(RegExp(r'[0-9]'));
                              if (!hasSymbol) {
                                return 'يجب ان تحتوي كلمة المرور على رموز';
                              }
                              if (!hasNumber) {
                                return 'يجب ان تحتوي كلمة المرور على ارقام';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextForm(
                            lable: 'تأكيد كلمة المرور',
                            myController: registerController.confirmPasswordController,
                            suffix: IconButton(
                              onPressed: () => registerController.changeVisiple2(),
                              icon: Icon(
                                registerController.visiple2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            obscureText: registerController.visiple2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الحقل فارغ";
                              }
                              if (value != registerController.passwordController.text) {
                                return 'غير مطابق لكلمة المرور';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SubmitBtn(onTap: () => registerController.register(), text: 'تسجيل')
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
