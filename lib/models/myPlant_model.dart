class MyPlantModel {
  final int id;
  final Plant? plant;

  MyPlantModel({
    required this.id,
    required this.plant,
  });

  factory MyPlantModel.fromJson(Map<String, dynamic> json) {
    return MyPlantModel(
      id: json['id'],
      plant: json['plant'] != null ? Plant.fromJson(json['plant']) : null,
    );
  }

  static List<MyPlantModel> myPlantsFromJson(List myPlantsListFromJson) {
    //print(myPlantsListFromJson[0]);
    return myPlantsListFromJson.map((data) {
      //print(data);
      return MyPlantModel.fromJson(data);
    }).toList();
  }
}

class Plant {
  final int plantId;
  final String name;
  final String image;
  final String soilType;
  final String scientificName;
  final String description;
  final String originalHabitat;
  final String uses;
  final String healthBenefits;
  final String preferredTimeToPlant;
  final String preferredTimeToHarvest;
  final String soilPH;
  final String irrigationForPlants;
  final String suitableFertilizers;
  final String useSuitableFertilizers;

  Plant({
    required this.plantId,
    required this.name,
    required this.image,
    required this.soilType,
    required this.scientificName,
    required this.description,
    required this.originalHabitat,
    required this.uses,
    required this.healthBenefits,
    required this.preferredTimeToPlant,
    required this.preferredTimeToHarvest,
    required this.soilPH,
    required this.irrigationForPlants,
    required this.suitableFertilizers,
    required this.useSuitableFertilizers,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      plantId: json['plantId'],
      name: json['name'],
      image: json['image'],
      soilType: json['soilType'],
      scientificName: json['scientificName'],
      description: json['description'],
      originalHabitat: json['originalHabitat'],
      uses: json['uses'],
      healthBenefits: json['healthBenefits'],
      preferredTimeToPlant: json['preferredTimeToPlant'],
      preferredTimeToHarvest: json['preferredTimeToHarvest'],
      soilPH: json['soilPH'],
      irrigationForPlants: json['irrigationForPlants'],
      suitableFertilizers: json['suitableFertilizers'],
      useSuitableFertilizers: json['useSuitableFertilizers'],
    );
  }
}


