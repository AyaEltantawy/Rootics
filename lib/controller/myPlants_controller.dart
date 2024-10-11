import 'package:get/get.dart';
import 'package:rootics_final/models/myPlant_model.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/services/api_service.dart';

class MyPlantController extends GetxController {
  var isLoading = true.obs;
  var myPlantList = <MyPlantModel>[].obs;

  @override
  void onInit() {
    fetchAllPlants();
    super.onInit();
  }
  
  void fetchAllPlants() async {
    try {
      isLoading(true);
      var plants = await ApiService.getMyPlants();

      if (plants != null) {
        myPlantList.assignAll(plants);
      }
    } finally {
      isLoading(false);
    }
  }
}
