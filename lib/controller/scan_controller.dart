import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rootics_final/models/myPlant_model.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/models/product_model.dart';
import 'package:rootics_final/services/api_service.dart';

class ScanController extends GetxController {
  var isLoading = true.obs;
  var diagnosisResult = ''.obs;
  var plantName = ''.obs;
  var plantStatus = ''.obs;
  var treatment = ''.obs;
  var selectedImagePath = ''.obs;

  // @override
  // void onInit() {
  //   diagnosisPlant();
  //   super.onInit();
  // }

  void diagnosisPlant() async {
    try {
      isLoading(true);
      var diagnosis =
          await ApiService.plantDiagnosis(imagePath: selectedImagePath.value);

      if (diagnosis != null) {
        diagnosisResult(diagnosis);
        split();
      }
    } finally {
      isLoading(false);
    }
  }

  void split() {
    List<String> parts = diagnosisResult.value.split('@');

    plantName(parts[0].trim());
    plantStatus(parts[1].trim());
    treatment(parts[2].trim());
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      diagnosisPlant();
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }
}
