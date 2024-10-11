import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rootics_final/controller/myPlants_controller.dart';
import 'package:rootics_final/controller/plant_controller.dart';
import 'package:rootics_final/controller/suggestedPlant_controller.dart';
import 'package:rootics_final/models/plant_model.dart';
//import 'package:rootics_final/models/suggestedPlant_model.dart';
import 'package:rootics_final/theme/app_colors.dart';
import 'package:rootics_final/view/allPlants_page.dart';

class HomePage extends StatelessWidget {
  final storage = GetStorage();
  PlantController plantController = Get.put(PlantController());
  SuggestedPlantController suggestedPlantsController =
      Get.put(SuggestedPlantController());
  MyPlantController myPlantController = Get.put(MyPlantController());

  final List time = [
    "نبات شتوي",
    "نبات صيفي",
    "نبات صيفي",
    "نبات صيفي و شتوي",
    "نبات صيفي",
    "نبات شتوي",
    "نبات شتوي",
    "نبات صيفي",
    "نبات شتوي",
  ];

  void logout() {
    // Remove the token from storage
    storage.remove('token');

    // Navigate to login page
    Get.offNamed('/login');
  }

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
                  //SizedBox(height: 1,),
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
                          ),
                        ),
                      ),
                      Positioned(
                          left: screenWidth * 0.05,
                          bottom: screenWidth * 0.7,
                          //top: screenHeitht * 0.5,
                          child: SingleChildScrollView(
                            child: Container(
                                height: screenHeitht * 3,
                                width: screenWidth * 0.9,
                                child: Column(
                                  children: [
                                    Obx(() {
                                      if (plantController.isLoading.value) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (plantController.allPlantList.isEmpty) {
                                        return Center(
                                          child: Text("No plants available."),
                                        );
                                      } 
                                      else {
                                        return CustomSlider(
                                            allPlantsList:
                                                plantController.allPlantList);
                                      }
                                    }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CustomBtn(text: "جميع النباتات", height: 50, width: 175,
                                    onPressed: () => Get.to(AllPlantsPage()),),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 190, bottom: 5),
                                      child: CustomBtn(text: "نباتات مقترحة", height: 35, width: 144,),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(() {
                                      if (suggestedPlantsController
                                          .isLoading.value) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (suggestedPlantsController
                                          .suggestedPlantList.isEmpty) {
                                        return Center(
                                          child: Text(
                                              "No suggested plants available."),
                                        );
                                      } else {
                                        return SizedBox(
                                          width: 360,
                                          height: 132,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                              itemCount: 7,
                                              itemBuilder: (context, i) =>
                                                  Container(
                                                      //width: 300,
                                                      height: 132,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffFFFFFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(21),
                                                          border: const Border(
                                                              bottom: BorderSide(
                                                                  width: 5,
                                                                  color: Color(
                                                                      0xff90E9C9)),
                                                              top: BorderSide(
                                                                  width: 5,
                                                                  color: Color(
                                                                      0xff90E9C9)),
                                                              right: BorderSide(
                                                                  width: 5,
                                                                  color: Color(0xff90E9C9)),
                                                              left: BorderSide(width: 5, color: Color(0xff90E9C9)))),
                                                      child: Row(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                suggestedPlantsController
                                                                    .suggestedPlantList[
                                                                        i]
                                                                    .name!,
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              //
                                                              SingleChildScrollView(
                                                                child: Text(
                                                                  suggestedPlantsController
                                                                      .suggestedPlantList[
                                                                          i]
                                                                      .description!,
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xff0F0F0F),
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            width: 190,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      left: BorderSide(
                                                                          width:
                                                                              15,
                                                                          color:
                                                                              Color(0xff23644e)),
                                                                    ),
                                                                    borderRadius: BorderRadius.horizontal(
                                                                        left: Radius.elliptical(
                                                                            220,
                                                                            400))),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "${suggestedPlantsController.suggestedPlantList[i].image!}",
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const Center(
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                            ))
                                                      ]))),
                                        );
                                      }
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, left: 250, top: 30),
                                      child: CustomBtn(text: "نباتاتي", height: 30, width: 80,),
                                    ),
                                    
                                    Obx(() {
                                      if (myPlantController.isLoading.value) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (myPlantController
                                          .myPlantList.isEmpty) {
                                        return Center(
                                          child: Text(
                                              "No plants available."),
                                        );
                                      } else {
                                        return SizedBox(
                                          height: 300,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4),
                                            child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                itemCount: 3,
                                                itemBuilder:
                                                    (context, i) => Row(
                                                          children: [
                                                            Container(
                                                              width: 340,
                                                              height: 132,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xffFFFFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              21),
                                                                  border: const Border(
                                                                      bottom: BorderSide(
                                                                          width:
                                                                              5,
                                                                          color: Color(
                                                                              0xff90E9C9)),
                                                                      top: BorderSide(
                                                                          width:
                                                                              5,
                                                                          color: Color(
                                                                              0xff90E9C9)),
                                                                      right: BorderSide(
                                                                          width:
                                                                              5,
                                                                          color: Color(
                                                                              0xff90E9C9)),
                                                                      left: BorderSide(
                                                                          width:
                                                                              5,
                                                                          color: Color(0xff90E9C9)))),
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            20,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                          myPlantController
                                                                              .myPlantList[i]
                                                                              .plant!
                                                                              .name,
                                                                          style: const TextStyle(
                                                                              color: Color(0xff000000),
                                                                              fontSize: 20),
                                                                        ),
                                                                        Text(
                                                                          time[
                                                                              i],
                                                                          style: const TextStyle(
                                                                              color: Color(0xff0F0F0F),
                                                                              fontSize: 15),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Container(
                                                                        width: 210,
                                                                        decoration: const BoxDecoration(
                                                                            border: Border(
                                                                              left: BorderSide(width: 15, color: Color(0xff23644e)),
                                                                            ),
                                                                            borderRadius: BorderRadius.horizontal(left: Radius.elliptical(220, 400))),
                                                                        child: CachedNetworkImage(
                                                                          imageUrl:
                                                                              "${myPlantController.myPlantList[i].plant!.image}",
                                                                          placeholder: (context, url) =>
                                                                              const Center(child: CircularProgressIndicator()),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                          ),
                                        );
                                      }
                                    })
                                  ],
                                )),
                          )),
                      // Positioned(
                      //   child: child)
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

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key, required this.allPlantsList});
  final List<PlantModel> allPlantsList;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  bool click = true;
  final List time = [
    "نبات شتوي",
    "نبات صيفي",
    "نبات صيفي",
    "نبات صيفي و شتوي",
    "نبات صيفي",
    "نبات شتوي",
    "نبات شتوي",
    "نبات صيفي",
    "نبات شتوي",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 300, 10, 0),
      child: (CarouselSlider.builder(
          itemCount: widget.allPlantsList.length,
          itemBuilder: (BuildContext context, i, int pageViewIndex) =>
              Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xff30B786),
                      borderRadius: BorderRadius.circular(15),
                      border: const Border(
                          right:
                              BorderSide(color: Color(0xff204338), width: 3.32),
                          bottom:
                              BorderSide(color: Color(0xff204338), width: 3.32),
                          top:
                              BorderSide(color: Color(0xff204338), width: 3.32),
                          left: BorderSide(
                              color: Color(0xff204338), width: 3.32))),
                  child: Column(children: [
                    Stack(
                      children: [
                        Container(
                            width: 144.69,
                            height: 100.55,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.elliptical(200, 95)),
                              border: Border(
                                bottom: BorderSide(
                                    color: Color(0xff90E9C9), width: 17.27),
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: "${widget.allPlantsList[i].image}",
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              imageBuilder: (context, imageProvider) {
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     PageTransition(
                                    //         type: PageTransitionType.fade,
                                    //         child: PlantDetailsScreen(
                                    //             id: widget.allPlantsList[index].plantId
                                    //                 .toString())));
                                  },
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              },
                            )),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(23, 80, 10, 0),
                            child: Container(
                              width: 92,
                              height: 22,
                              child: SizedBox(
                                width: 92,
                                height: 22,
                                child: MaterialButton(
                                    height: 5,
                                    minWidth: 10,
                                    color: click
                                        ? const Color(0xff90E9C9)
                                        : const Color(0xff204338),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        side: BorderSide(
                                            width: .66,
                                            color: Color(0xff0F0F0F))),
                                    onPressed: () {
                                      setState(() {
                                        click = !click;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.favorite,
                                            size: 20,
                                            color: click
                                                ? const Color(0xff204338)
                                                : const Color(0xff90E9C9)),
                                        const SizedBox(
                                          width: 1,
                                        ),
                                        Text("اضافة",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: click
                                                  ? const Color(0xff204338)
                                                  : const Color(0xffFFFFFF),
                                            )),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 106, 5, 0),
                          child: Text("${widget.allPlantsList[i].name}",
                              style: const TextStyle(
                                  fontSize: 17, color: Color(0xff0F0F0F))),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(3, 132, 0, 0),
                            child: Center(
                              child: Text(time[i],
                                  style: const TextStyle(
                                      fontSize: 15, color: Color(0xff0F0F0F))),
                            )),
                      ],
                    )
                  ])),
          options: CarouselOptions(
            height: 230,
            aspectRatio: 16 / 9,
            viewportFraction: 0.6,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOutCirc,
            enlargeCenterPage: true,
            enlargeFactor: .3,
            onPageChanged: (index, reason) {},
            scrollDirection: Axis.horizontal,
          ))),
    );
  }
}

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
      required this.text,
      required this.height,
      required this.width,
      this.onPressed});
  final String text;
  final double height;
  final double width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: const Color(0xff2BD598),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide(width: 3, color: Color(0xff90E9C9))),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: Color(0xff204338), fontSize: 20),
      ),
    );
  }
}
