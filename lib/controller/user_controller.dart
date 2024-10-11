import 'package:get/get.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/models/user_model.dart';
import 'package:rootics_final/services/api_service.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var user = UserModel().obs;

  @override
  void onInit() {
    fetchAllPlants();
    //fetchOnlyPlants(id: id);
    super.onInit();
  }

  void fetchAllPlants() async {
    try {
      isLoading(true);
      var userData = await ApiService.getUserData();

      if (userData != null) {
        user.value = userData;
      }
    } finally {
      isLoading(false);
    }
  }
}
