import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:rootics_final/controller/scan_controller.dart';
import 'package:rootics_final/theme/app_colors.dart';

class ScanPage extends StatelessWidget {
  ScanPage({super.key});
  ScanController scanController = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("lib/assets/images/scan.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  //width: screenWidth,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors().darkGreen, width: 4),
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors().lightGreen,
                    //boxShadow: const [BoxShadow(blurRadius: 2, offset: Offset(0, 2))]
                  ),
                  child: Center(
                      child: Text(
                    "رفع صورة",
                    style:
                        TextStyle(color: AppColors().darkGreen, fontSize: 30),
                  )),
                ),
                onTap: () => scanController.getImage(ImageSource.gallery),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors().darkGreen, width: 4),
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors().lightGreen,
                  ),
                  child: Center(
                      child: Text(
                    "كاميرا ",
                    style:
                        TextStyle(color: AppColors().darkGreen, fontSize: 30),
                  )),
                ),
                onTap: () => scanController.getImage(ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
