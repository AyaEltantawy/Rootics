import 'dart:convert';
//import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rootics_final/models/myPlant_model.dart';
import 'package:rootics_final/models/plant_model.dart';
import 'package:rootics_final/models/product_model.dart';
import 'package:rootics_final/models/suggestedPlant_model.dart';
import 'package:rootics_final/models/task_model.dart';
import 'package:rootics_final/models/user_model.dart';
import 'package:rootics_final/utils/api_endpoints.dart';
import 'package:rootics_final/view/diagnosis_page.dart';

class ApiService {
  static final GetStorage storage = GetStorage();

  //-----------------------------GetData----------------------------------------

  static Future<List<dynamic>> getData(
      {required String target, required String token}) async {
    List tempList = [];
    try {
      var response = await http.get(Uri.parse(target), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        //print(responseBody);
        for (var v in responseBody) {
          tempList.add(v);
        }
        //return responseBody;
      } else {
        print(response.statusCode);
        throw jsonDecode(response.body)['message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      //Get.back();
      Get.snackbar("Error", e.toString());
      print(e.toString());
    }
    return tempList;
  }

  static Future<List<PlantModel>> getAllPlants() async {
    String? token = storage.read('token');
    List temp = await getData(target: linkGetAllPlants, token: token!);
    return PlantModel.allPlantsFromJson(temp);
  }

  static Future<List<SuggestedPlantsModel>> getSuggestedPlants() async {
    String? token = storage.read('token');
    List temp = await getData(target: linkGetAllPlants, token: token!);
    return SuggestedPlantsModel.suggestedPlantsFromJson(temp);
  }

  static Future<List<MyPlantModel>> getMyPlants() async {
    String? token = storage.read('token');
    List temp = await getData(target: linkGetMyPlants, token: token!);
    return MyPlantModel.myPlantsFromJson(temp);
  }

  static Future<List<TaskModel>> getAllTasks() async {
    String? token = storage.read('token');
    List temp = await getData(target: linkTask, token: token!);
    return TaskModel.taskFromJson(temp);
  }

  static Future<List<ProductModel>> getProducts() async {
    String? token = storage.read('token');
    List temp = await getData(target: linkMarket, token: token!);
    return ProductModel.productFromJson(temp);
  }

  // Future<Map<String, dynamic>?> getProfileData() async {
  //   String? token = storage.read('token');
  //   try {
  //     var response = await http.get(
  //       Uri.parse(linkGetUserInfo),
  //       headers: {
  //         //'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       var responseBody = jsonDecode(response.body);
  //       return responseBody;
  //     } else {
  //       print('Failed to load profile data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  //   return null;
  // }

  static Future<UserModel?> getUserData() async {
    String? token = storage.read('token');
    try {
    final response = await http.get(Uri.parse(linkGetUserInfo),headers: {
        //'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return UserModel.fromJson(jsonResponse);
    } else {
      print('Failed to load user data: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}

  //-----------------------------PostData--------------------------------------

  static Future<int> postTask({
    required int id,
    required String task,
    required int taskTime,
  }) async {
    String? token = storage.read('token');
    try {
      var response = await http.post(
        Uri.parse("$linkTask/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"description": task, 'taskTime': taskTime}),
      );

      if (response.statusCode == 200) {
        print("Request successful: ${response.body}");
        return response.statusCode;
      } else {
        var responseBody = jsonDecode(response.body);
        print("Error in request: ${response.statusCode}, $responseBody");
        return response.statusCode;
        //return jsonDecode(response.body)['message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      print("An error occurred during the request: $e");
      return Future.error(e.toString());
    }
  }

  static Future<int> postProduct(
      {required String tretName,
      required String compName,
      required String use,
      required String imagePath}) async {
    String? token = storage.read('token');
    try {
      var request = http.MultipartRequest('POST', Uri.parse(linkMarket));
      request.headers.addAll({
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibW9obWVkQWRtaW4zIiwianRpIjoiM2MzNzQ1MjEtMTU2OC00OGMyLTllY2MtNTU1MzZhODY0MDRlIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3MTk4MDQ2OTUsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcwMzgiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjQyMDAifQ.7_hirXUejoUn-2fmeX9RjmQh4rngTNfzAC1aW7w1mBs',
      });
      request.fields['PlantDiseaseName'] = use;
      request.fields['MedicineName'] = tretName;
      request.fields['CompanyName'] = compName;

      var imageFile = await http.MultipartFile.fromPath(
        'TreatmentImage',
        imagePath,
      );
      request.files.add(imageFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        print("Product added to list successfully");
        return response.statusCode;
      } else {
        var responseBody = await response.stream.bytesToString();
        print("Error adding product to list: ${response.statusCode}");
        return response.statusCode;
        //return jsonDecode(response.body)['message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      print("An error occurred during the request: $e");
      return Future.error(e.toString());
    }
  }

  //-----------------------------DeleteData--------------------------------------

  static Future<int> deleteTask({
    required int id,
  }) async {
    String? token = storage.read('token');
    try {
      var response = await http.delete(
        Uri.parse('$linkTask/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Task deleted from list successfully");
        return response.statusCode;
      } else {
        var responseBody = jsonDecode(response.body);
        print("Error deleting task from list: ${response.statusCode}");
        return response.statusCode;
      }
    } catch (e) {
      print("An error occurred while deleting task from list: $e");
      return Future.error(e.toString());
    }
  }

  //-----------------------------Diagnosis--------------------------------------

  static Future<String?> plantDiagnosis({required String imagePath}) async {
    try {
      dio.Dio dioInstance = dio.Dio();

      dio.FormData formData = dio.FormData.fromMap({
        'file':
            await dio.MultipartFile.fromFile(imagePath, filename: 'image.png'),
      });

      var response = await dioInstance.post(
        linkPlantDiagnosis,
        data: formData,
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        String? plantStatus = responseData["النوع"];
        if (plantStatus != null) {
          Get.to(DiagnosisPage(
            imagePath: imagePath,
          ));
          print('Identification successful: $plantStatus');
          return plantStatus;
        } else {
          print(
              'Identification failed: Response data does not contain "النوع"');
          print(response.statusCode);
          print('Response body: ${response.data}');
        }
      } else {
        print('Identification failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during identification: $e');
      return Future.error(e.toString());
    }

    return null;
  }
}
