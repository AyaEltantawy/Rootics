import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/controller/scan_controller.dart';
import 'package:rootics_final/theme/app_colors.dart';
import 'package:rootics_final/view/market_page.dart';

class DiagnosisPage extends StatelessWidget {
  DiagnosisPage({super.key, required this.imagePath});
  final String imagePath;
  ScanController scanController = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    double screenHeitht = MediaQuery.of(context).size.height;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(
          () => Scaffold(
            extendBodyBehindAppBar: true,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  leading: const BackButton(),
                  expandedHeight: 240,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "نبات ال${scanController.plantName.value}",
                      style: TextStyle(color: AppColors().darkGreen),
                    ),
                    titlePadding: const EdgeInsets.only(bottom: 15, right: 50),
                    background: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(imagePath)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  floating: true,
                  pinned: true,
                  backgroundColor: AppColors().lightGreen,
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
                          DataColumn(label: SizedBox()),
                          DataColumn(label: SizedBox()),
                        ],
                        rows: <DataRow>[
                          buildRow('اسم النبات', "نبات ال${scanController.plantName.value}"),
                          buildRow2('حالته', scanController.plantStatus.value),
                          buildRow('العلاج', scanController.treatment.value),
                        ],
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () => Get.to(MarketPage()),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors().lightGreen, width: 4),
                            borderRadius: BorderRadius.circular(13),
                            color: AppColors().lightGreen2,
                            boxShadow: const [
                              BoxShadow(blurRadius: 2, offset: Offset(0, 2)),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "عرض المنتجات",
                              style: TextStyle(
                                  color: AppColors().darkGreen, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

DataRow buildRow(
  String label,
  String value,
) {
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
