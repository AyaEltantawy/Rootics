import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rootics_final/controller/product_controller.dart';
import 'package:rootics_final/models/product_model.dart';
import 'package:rootics_final/theme/app_colors.dart';
import 'package:rootics_final/view/productInfo_page.dart';

class MarketPage extends StatelessWidget {
  MarketPage({super.key});
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeitht,
            width: screenWidth,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [AppColors().lightGreen, AppColors().darkGreen2],
                    focal: Alignment.center,
                    radius: .8)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Arc(
                          arcType: ArcType.CONVEX,
                          edge: Edge.BOTTOM,
                          height: 60,
                          child: Container(
                            height: screenHeitht * 0.28,
                            width: screenWidth,
                            color: AppColors().lightGreen,
                          )),
                      Arc(
                          arcType: ArcType.CONVEX,
                          edge: Edge.BOTTOM,
                          height: 60,
                          child: Container(
                            height: screenHeitht * 0.27,
                            width: screenWidth,
                            color: AppColors().darkGreen,
                          )),
                      Center(
                        child: Image.asset(
                          "lib/assets/images/logo.png",
                          width: 220,
                          height: 220,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: screenHeitht * 3,
                        width: screenWidth,
                        color: const Color.fromARGB(0, 252, 252, 252),
                      ),
                      Positioned(
                        top: screenHeitht * 0.15,
                        child: Arc(
                            arcType: ArcType.CONVEX,
                            edge: Edge.TOP,
                            height: 60,
                            child: Container(
                              height: screenHeitht * 3,
                              width: screenWidth,
                              color: AppColors().lightGreen,
                            )),
                      ),
                      Positioned(
                        top: screenHeitht * 0.16,
                        child: Arc(
                            arcType: ArcType.CONVEX,
                            edge: Edge.TOP,
                            height: 60,
                            child: Container(
                              height: screenHeitht * 3,
                              width: screenWidth,
                              color: AppColors().darkGreen,
                            )),
                      ),
                      Positioned(
                        left: screenWidth * 0.05,
                        top: screenHeitht * 0.03,
                        child: Container(
                            height: screenHeitht * 3,
                            width: screenWidth * 0.9,
                            child: Obx(() {
                                if (productController.isLoading.value) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (productController.productList.isEmpty) {
                                  return Center(
                                    child:
                                        Text("No products available."),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      GridB(
                                          productList:
                                              productController.productList),
                                              const SizedBox(height: 50.0),
                               
                                    ],
                                  );
                                }
                              })),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key, required this.productList}) : super(key: key);

  final List<ProductModel> productList;

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          mainAxisExtent: 250,
        ),
        itemCount: widget.productList.length,
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors().darkGreen, width: 4),
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors().lightGreen),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    child: CachedNetworkImage(
                      imageUrl: widget.productList[index].treatmentImage,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      imageBuilder: (context, imageProvider) {
                        return InkWell(
                          onTap: () => Get.to(ProductInfoPage(product: widget.productList[index])),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0)),
                      color: AppColors().lightGreen3,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120,bottom: 10,left: 10,right: 10),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: AppColors().lightGreen,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                            widget.productList[index].medicineName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                      ),
                    ),
                  ),
                ),
              ]
            ),
          );
        });
  }
}
