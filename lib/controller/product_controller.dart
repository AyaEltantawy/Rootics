import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rootics_final/models/myPlant_model.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/models/product_model.dart';
import 'package:rootics_final/services/api_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var isProssing = false.obs;
  var productList = <ProductModel>[].obs;

  TextEditingController productNameController = TextEditingController();
  TextEditingController useController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  //File? pickedFile;
  var selectedImagePath = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var plants = await ApiService.getProducts();

      if (plants != null) {
        productList.assignAll(plants);
      }
    } finally {
      isLoading(false);
    }
  }

  void addProduct(
      {required String productName,
      required String companyName,
      required String use,
      required String imagePath}) {
    try {
      isProssing(true);
      ApiService.postProduct(
              tretName: productName,
              compName: companyName,
              use: use,
              imagePath: imagePath)
          .then((response) {
        if (response == 200) {
          productNameController.clear();
          useController.clear();
          companyNameController.clear();
          isProssing(false);

          Get.snackbar("Add Product", "product added succesfuly");
          print(response);
        } else {
          Get.snackbar("Add Product", "faild to add product");
        }
      });
    } catch (e) {
      isProssing(false);
      Get.snackbar("Error", e.toString());
    }
  }

  // void getImage(ImageSource imageSource) async {
  //   final pickedFile = ImagePicker().pickImage(source: imageSource);
  //   if (PickedFile != null) {
  //     selectedImagePath.value = pickedFile.path;
  //   } else {
  //     Get.snackbar('Error', 'No image selected');
  //   }
  // }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }
}
