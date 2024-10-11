import 'package:flutter/material.dart';

// class AllPlantsModel with ChangeNotifier {
//   int? plantId;
//   String? name;
//   String? image;
//   String? description;

//   AllPlantsModel({this.plantId, this.name, this.image, this.description});

//   AllPlantsModel.fromJson(Map<String, dynamic> json) {
//     plantId = json['plantId'];
//     name = json['name'];
//     image = json['image'];
//     description = json['description'];
//   }

  // static List<AllPlantsModel> allPlantsFromJson(List allPlantsListFromJson) {
  //   //print(allPlantsListFromJson[0]);
  //   return allPlantsListFromJson.map((data) {
  //     //print(data);
  //     return AllPlantsModel.fromJson(data);
  //   }).toList();
  // }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = {};
//   //   data['plantId'] = plantId;
//   //   data['name'] = name;
//   //   data['image'] = image;
//   //   data['description'] = description;
//   //   return data;
//   // }
// }


class PlantModel with ChangeNotifier {
  int? plantId;
  String? name;
  String? image;
  String? soilType;
  String? scientificName;
  String? description;
  String? originalHabitat;
  String? uses;
  String? healthBenefits;
  String? preferredTimeToPlant;
  String? preferredTimeToHarvest;
  String? soilPH;
  String? irrigationForPlants;
  String? suitableFertilizers;
  String? useSuitableFertilizers;

  PlantModel(
      {this.plantId,
      this.name,
      this.image,
      this.soilType,
      this.scientificName,
      this.description,
      this.originalHabitat,
      this.uses,
      this.healthBenefits,
      this.preferredTimeToPlant,
      this.preferredTimeToHarvest,
      this.soilPH,
      this.irrigationForPlants,
      this.suitableFertilizers,
      this.useSuitableFertilizers});

  PlantModel.fromJson(Map<String, dynamic> json) {
    plantId = json['plantId'];
    name = json['name'];
    image = json['image'];
    soilType = json['soilType'];
    scientificName = json['scientificName'];
    description = json['description'];
    originalHabitat = json['originalHabitat'];
    uses = json['uses'];
    healthBenefits = json['healthBenefits'];
    preferredTimeToPlant = json['preferredTimeToPlant'];
    preferredTimeToHarvest = json['preferredTimeToHarvest'];
    soilPH = json['soilPH'];
    irrigationForPlants = json['irrigationForPlants'];
    suitableFertilizers = json['suitableFertilizers'];
    useSuitableFertilizers = json['useSuitableFertilizers'];
  }

    static List<PlantModel> allPlantsFromJson(List allPlantsListFromJson) {
    //print(allPlantsListFromJson[0]);
    return allPlantsListFromJson.map((data) {
      //print(data);
      return PlantModel.fromJson(data);
    }).toList();
  }

  // static List<PlantsModel> myPlantsFromJson(List myPlantsListFromJson) {
  //   print(myPlantsListFromJson[0]);
  //   return myPlantsListFromJson.map((data) {
  //     //print(data);
  //     return PlantsModel.fromJson(data);
  //   }).toList();
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['plantId'] = this.plantId;
  //   data['name'] = this.name;
  //   data['image'] = this.image;
  //   data['soilType'] = this.soilType;
  //   data['scientificName'] = this.scientificName;
  //   data['description'] = this.description;
  //   data['originalHabitat'] = this.originalHabitat;
  //   data['uses'] = this.uses;
  //   data['healthBenefits'] = this.healthBenefits;
  //   data['preferredTimeToPlant'] = this.preferredTimeToPlant;
  //   data['preferredTimeToHarvest'] = this.preferredTimeToHarvest;
  //   data['soilPH'] = this.soilPH;
  //   data['irrigationForPlants'] = this.irrigationForPlants;
  //   data['suitableFertilizers'] = this.suitableFertilizers;
  //   data['useSuitableFertilizers'] = this.useSuitableFertilizers;
  //   return data;
  //}
}