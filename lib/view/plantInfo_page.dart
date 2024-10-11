import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/controller/myPlants_controller.dart';
import 'package:rootics_final/controller/plant_controller.dart';
import 'package:rootics_final/models/myPlant_model.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/theme/app_colors.dart';

class PlantInfoPage extends StatelessWidget {
  PlantInfoPage({super.key, required this.plant});
  //final int id;
  MyPlantController plantController = Get.put(MyPlantController());
  final MyPlantModel plant;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (plantController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (plant == null) {
            return Center(
              child: Text("No suggested plants available."),
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
                                  plant.plant!.name,
                                  style:
                                      TextStyle(color: AppColors().darkGreen),
                                ),
                                titlePadding: const EdgeInsets.only(
                                    bottom: 15, right: 50),
                                background: CachedNetworkImage(
                                  imageUrl: plant.plant!.image.toString(),
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
                        //height: screenHeitht*2,
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
                                buildRow('الاسم العلمي:',
                                    "${plant.plant!.scientificName}"),
                                buildRow2(
                                    'الوصف:', "${plant.plant!.description}"),
                                buildRow(
                                    'نوع التربة:', "${plant.plant!.soilType}"),
                                buildRow2(
                                    'حموضة التربة:', "${plant.plant!.soilPH}"),
                                buildRow('الري',
                                    "${plant.plant!.irrigationForPlants}"),
                                buildRow2('السماد المناسب:',
                                    "${plant.plant!.suitableFertilizers}"),
                                buildRow('مرات التسميد:',
                                    "${plant.plant!.useSuitableFertilizers}"),
                                buildRow2(
                                    'الاستخدامات:', "${plant.plant!.uses}"),
                                buildRow('الفوائد الصحية:',
                                    "${plant.plant!.healthBenefits}"),
                                buildRow2('الموطن الاصلي:',
                                    "${plant.plant!.originalHabitat}"),
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
