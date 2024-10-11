import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rootics_final/controller/myPlants_controller.dart';
import 'package:rootics_final/controller/notification_controller.dart';
//import 'package:rootics_final/controller/plant_controller.dart';
import 'package:rootics_final/controller/task_controller.dart';
import 'package:rootics_final/custom_widgets/txtFormField.dart';
import 'package:rootics_final/models/myPlant_model.dart';
//import 'package:rootics_final/models/plant_model.dart';
//import 'package:rootics_final/services/api_service.dart';
import 'package:rootics_final/theme/app_colors.dart';
//import 'package:rootics_final/theme/app_icons.dart';
import 'package:rootics_final/view/plantInfo_page.dart';
import 'package:rootics_final/view/tasks_page.dart';

class MyPlantsPage extends StatefulWidget {
  const MyPlantsPage({super.key});

  @override
  State<MyPlantsPage> createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  //PlantController plantController = Get.put(PlantController());
  MyPlantController myPlantController = Get.put(MyPlantController());
  final NotificationController notificationController =
      Get.put(NotificationController());
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
                            )),
                      ),
                      Positioned(
                          left: screenWidth * 0.05,
                          top: screenHeitht * 0.03,
                          child: Container(
                              height: screenHeitht * 3,
                              width: screenWidth * 0.9,
                              child: Obx(() {
                                if (myPlantController.isLoading.value) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (myPlantController.myPlantList.isEmpty) {
                                  return Center(
                                    child:
                                        Text("No suggested plants available."),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      GridB(
                                          myPlantsList:
                                              myPlantController.myPlantList),
                                              const SizedBox(height: 50.0),
                                GestureDetector(
                                  onTap: () => Get.to(TasksPage()),
                                  child: Container(
                                    width: screenWidth*0.35,
                                    height: screenHeitht*0.2,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                            color: AppColors().lightGreen,
                                            width: 5),
                                        color: AppColors().darkGreen3),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          const Image(
                                              image: AssetImage(
                                                  "lib/assets/images/task.png")),
                                          Text(
                                            'قائمة المهام',
                                            style: TextStyle(
                                                color: AppColors().lightGreen,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                    ],
                                  );
                                }
                              })
                              ))
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

class GridB extends StatelessWidget {
  GridB({
    super.key,
    required this.myPlantsList,
  });

  final List<MyPlantModel> myPlantsList;
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
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          mainAxisExtent: 250,
        ),
        itemCount: myPlantsList.length,
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
                      imageUrl: myPlantsList[index].plant!.image,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      imageBuilder: (context, imageProvider) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => PlantInfoPage(plant: myPlantsList[index]));
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
                          const EdgeInsets.only(top: 105, left: 20, right: 20),
                      child: MaterialButton(
                        height: 5,
                        //minWidth: 10,
                        color: AppColors().lightGreen,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            side: BorderSide(
                                width: .66, color: Color(0xff0F0F0F))),
                        onPressed: () => Get.bottomSheet(CustomBottomSheet(
                            myPlantsList: myPlantsList, index: index)),
                        child: Text("اضف مهمة",
                            style: TextStyle(
                                fontSize: 17, color: AppColors().darkGreen)),
                      ),
                    ),
                    Center(
                        child: Text(
                      myPlantsList[index].plant!.name,
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

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet(
      {super.key, required this.myPlantsList, required this.index});
  TaskController taskController = Get.put(TaskController());
  NotificationController notificationController =
      Get.put(NotificationController());
  final List<MyPlantModel> myPlantsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextForm(
                    myController: taskController.descriptionController,
                    lable: "أدخل المهمة",
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextForm(
                    myController: taskController.notifyController,
                    lable: "التذكير بعد",
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 100,
                  color: AppColors().lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      side: BorderSide(width: .66, color: AppColors().darkGreen)),
                  onPressed: () {
                    if (taskController.isProssing.value == false) {
                      notificationController.showCustomRepeatedNotification(
                          plantId: myPlantsList[index].plant!.plantId,
                          plantName: myPlantsList[index].plant!.name,
                          task: taskController.descriptionController.text,
                          interval:
                              int.parse(taskController.notifyController.text));
                      taskController.addTask(
                          id: myPlantsList[index].id,
                          task: taskController.descriptionController.text,
                          taskTime:
                              int.parse(taskController.notifyController.text));      
                    }
            
                    Get.back();
                  },
                  child: Text(
                    taskController.isProssing.value == true ? 'Prossing' : 'اضافة',
                    style: TextStyle(fontSize: 17, color: AppColors().darkGreen),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
