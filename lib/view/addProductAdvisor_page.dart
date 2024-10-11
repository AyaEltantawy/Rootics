import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rootics_final/controller/product_controller.dart';
import 'package:rootics_final/custom_widgets/txtFormField.dart';
import 'package:rootics_final/theme/app_colors.dart';

class AddProductAdvisorPage extends StatelessWidget {
  AddProductAdvisorPage({super.key});
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() =>
          Scaffold(
              appBar: AppBar(
                title: Text(
                  "اضافة منتج",
                  style: TextStyle(color: AppColors().lightGreen),
                ),
                leading: BackButton(
                  color: AppColors().lightGreen,
                ),
                backgroundColor: AppColors().darkGreen,
              ),
              body: Container(
                width: screenWidth,
                height: screenHeitht,
                color: AppColors().darkGreen,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 100, left: 20, right: 20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.ce)nter,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TxtField(
                          lable: "اسم المنتج",
                          myController: productController.productNameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TxtField(
                          lable: "الاستخدام",
                          myController: productController.useController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TxtField(
                          lable: "الشركة المنتجة",
                          myController: productController.companyNameController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        productController.selectedImagePath.value == ''
                            ? Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors().lightGreen3,
                                        width: 4),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton(
                                  onPressed: () => productController
                                      .getImage(ImageSource.gallery),
                                  child: Text(
                                    'Select Image',
                                    style: TextStyle(
                                        color: AppColors().lightGreen),
                                  ),
                                ),
                              )
                            : Container(
                                width: 200,
                                height: 200,
                                //color: AppColors().lightGreen,
                                child: Center(
                                  child: Image.file(
                                    File(productController
                                        .selectedImagePath.value),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        // ElevatedButton(
                        //     onPressed: selectFile, child: Text('Select File')),
                        InkWell(
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors().lightGreen, width: 4),
                                borderRadius: BorderRadius.circular(13),
                                color: AppColors().lightGreen2,
                                boxShadow: const [
                                  BoxShadow(blurRadius: 2, offset: Offset(0, 2))
                                ]),
                            child: Center(
                                child: Text(
                              "submit",
                              style: TextStyle(
                                  color: AppColors().darkGreen, fontSize: 20),
                            )),
                          ),
                          onTap: () {
                            if (productController.selectedImagePath.value !=
                                null) {
                              productController.addProduct(
                                  productName: productController
                                      .productNameController.text,
                                  companyName: productController
                                      .companyNameController.text,
                                  use: productController.useController.text,
                                  imagePath: productController
                                      .selectedImagePath.value);
                            } else {
                              print("No file selected to upload.");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ));
  }
}
