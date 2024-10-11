import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/controller/user_controller.dart';
import 'package:rootics_final/theme/app_colors.dart';
import 'package:rootics_final/view/editProfile_page.dart';

class ProfileInfoPage extends StatelessWidget {
  ProfileInfoPage({super.key});
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors().lightGreen,
            leading: BackButton(),
          ),
          body: Obx(() {
            if (userController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (userController.user.value == null) {
              return Center(child: Text('No user data found'));
            } else {
              final user = userController.user.value;
              return Container(
                color: AppColors().lightGreen,
                  height: screenHeitht,
                  width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: user.imageUrl != null
                            ? NetworkImage(user.imageUrl!)
                            : AssetImage('lib/assets/images/defaultUser.png')
                                as ImageProvider,
                      ),
                      SizedBox(height: 16),
                      Text(
                        user.username!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // ElevatedButton.icon(
                      //   onPressed: () => Get.to(EditProfilePage()),
                      //   icon: Icon(Icons.edit),
                      //   label: Text('تعديل'),
                      // ),
                      SizedBox(height: 16),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'البريد الالكتروني',
                          hintText:user.email,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'العنوان',
                          hintText: user.address,
                        ),
                      ),
                       SizedBox(height: 16),
                      TextField(
                        readOnly: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'تاريخ الميلاد',
                          hintText: user.dateOfBirth,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          })),
    );
  }
}
