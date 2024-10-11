import 'package:get/get.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/models/suggestedPlant_model.dart';
import 'package:rootics_final/services/api_service.dart';

class SuggestedPlantController extends GetxController {
  var isLoading = true.obs;
  var suggestedPlantList = <SuggestedPlantsModel>[].obs;

  @override
  void onInit() {
    fetchAllPlants();
    super.onInit();
  }

  void fetchAllPlants() async {
    try {
      isLoading(true);
      var plants = await ApiService.getSuggestedPlants();

      if (plants != null) {
        suggestedPlantList.assignAll(plants);
      }
    } finally {
      isLoading(false);
    }
  }
}
