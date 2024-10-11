import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rootics_final/controller/plant_controller.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/theme/app_colors.dart';
import 'package:rootics_final/theme/app_icons.dart';

class AllPlantsPage extends StatefulWidget {
  const AllPlantsPage({super.key});

  @override
  State<AllPlantsPage> createState() => _AllPlantsPageState();
}

class _AllPlantsPageState extends State<AllPlantsPage> {
  PlantController plantController = Get.put(PlantController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
          Stack(
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
                            )),
                      ),
                      Positioned(
                          left: screenWidth * 0.05,
                          top: screenHeitht * 0.03,
                          child: Container(
                              height: screenHeitht * 3,
                              width: screenWidth * 0.9,
                              child: Obx(() {
                                if (plantController.isLoading.value) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return GridB(
                                      allPlantsList:
                                          plantController.allPlantList);
                                }
                              })))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //}
      //},
      //),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key, required this.allPlantsList}) : super(key: key);

  final List<PlantModel> allPlantsList;

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  late List<bool> _isClickedList;
  //late List<AllPlantsModel> allPlantsList;
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
  void initState() {
    super.initState();
    _isClickedList = List<bool>.filled(widget.allPlantsList.length, true);
  }

  void changeButtonColor(int index) {
    setState(() {
      _isClickedList[index] = !_isClickedList[index];
    });
  }

  // Future<void> addPlatToMyPlants({
  //   required String id,
  // }) async {
  //   await ApiHandler.postPlantToMyList(id: id);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    //final AllPlantsModel allPlantsModelProvider = Provider.of<AllPlantsModel>(context);
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          mainAxisExtent: 250,
        ),
        itemCount: widget.allPlantsList.length,
        itemBuilder: (_, index) {
          return 
          Container(
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
                      imageUrl: "${widget.allPlantsList[index].image}",
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
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
                  child: Arc(
                      arcType: ArcType.CONVEY,
                      edge: Edge.TOP,
                      height: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)),
                          color: AppColors().lightGreen,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 110),
                  child: Arc(
                      arcType: ArcType.CONVEY,
                      edge: Edge.TOP,
                      height: 25,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0)),
                          color: AppColors().lightGreen3,
                        ),
                      )),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 105, left: 30, right: 30),
                      child: MaterialButton(
                          height: 5,
                          //minWidth: 10,
                          color: _isClickedList[index]
                              ? AppColors().lightGreen
                              : AppColors().darkGreen,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              side: BorderSide(
                                  width: .66, color: Color(0xff0F0F0F))),
                          onPressed: () {
                            changeButtonColor(index);
                            // addPlatToMyPlants(
                            //   id: widget.allPlantsList[index].plantId
                            //       .toString(),
                            // );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(AppIcons.heart,
                                  size: 15,
                                  color: _isClickedList[index]
                                      ? AppColors().darkGreen
                                      : AppColors().lightGreen),
                              Text("اضافة",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: _isClickedList[index]
                                        ? const Color(0xff204338)
                                        : const Color(0xffFFFFFF),
                                  )),

                              // const SizedBox(
                              //   width: 1,
                              // ),
                            ],
                          )),
                    ),
                    Center(
                        child: Text(
                      "${widget.allPlantsList[index].name}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${time[index]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}