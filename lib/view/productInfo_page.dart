import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rootics_final/controller/product_controller.dart';
import 'package:rootics_final/models/product_model.dart';
import 'package:rootics_final/theme/app_colors.dart';

class ProductInfoPage extends StatelessWidget {
  ProductInfoPage({super.key, required this.product});
  ProductController productController = Get.put(ProductController());
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (productController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (product == null) {
            return Center(
              child: Text("No products available."),
            );
          } else {
            return Scaffold(
                extendBodyBehindAppBar: true,
                body: NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverAppBar(
                            //forceMaterialTransparency: true,
                            //backgroundColor: Colors.amber,
                            leading: const BackButton(),
                            expandedHeight: 240,
                            flexibleSpace: FlexibleSpaceBar(
                                title: Text(
                                  product.medicineName,
                                  style:
                                      TextStyle(color: AppColors().darkGreen),
                                ),
                                titlePadding: const EdgeInsets.only(
                                    bottom: 15, right: 50),
                                background: CachedNetworkImage(
                                  imageUrl: product.treatmentImage.toString(),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                    );
                                  },
                                )),
                            floating: true,
                            pinned: true,
                            backgroundColor: AppColors().lightGreen2,
                          ),
                        ],
                    body: SingleChildScrollView(
                      child: Container(
                        height: screenHeitht,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors().lightGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            DataTable(
                              columnSpacing: 16,
                              horizontalMargin: 16,
                              dataRowHeight: 100,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: SizedBox(),
                                ),
                                DataColumn(
                                  label: SizedBox(),
                                ),
                              ],
                              rows: <DataRow>[
                                buildRow('اسم المنتج :',
                                    product.medicineName),
                                buildRow2('الشركة المنتجة:',
                                    product.companyName),
                                buildRow('يستخدم لعلاج :',
                                    product.plantDiseaseName),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    )));
          }
        }));
  }
}

DataRow buildRow(String label, String value) {
  return DataRow(
    cells: <DataCell>[
      DataCell(Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: TextStyle(
              color: Colors.teal[900],
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
      )),
    ],
  );
}

DataRow buildRow2(String label, String value) {
  return DataRow(
    color: const WidgetStatePropertyAll(
      Color.fromARGB(255, 169, 241, 215),
    ),
    cells: <DataCell>[
      DataCell(Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: TextStyle(
              color: Colors.teal[900],
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
      )),
    ],
  );
}

