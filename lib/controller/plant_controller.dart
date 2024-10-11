import 'package:get/get.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/services/api_service.dart';

class PlantController extends GetxController {
  var isLoading = true.obs;
  var allPlantList = <PlantModel>[].obs;
  var plant = PlantModel().obs;
  late int id;

  @override
  void onInit() {
    fetchAllPlants();
    //fetchOnlyPlants(id: id);
    super.onInit();
  }

  void fetchAllPlants() async {
    try {
      isLoading(true);
      var plants = await ApiService.getAllPlants();

      if (plants != null) {
        allPlantList.assignAll(plants);
      }
    } finally {
      isLoading(false);
    }
  }

  // void fetchOnlyPlants() async {
  //   try {
  //     isLoading(true);
  //     var fetchedPlant = await ApiService.getOnlyPlant(id: id);

  //     if (fetchedPlant != null) {
  //       plant.value = fetchedPlant;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
