class TaskModel {
  final int id;
  final String description;
  final Plant plant;
  final int taskTime;

  TaskModel({
    required this.id,
    required this.description,
    required this.plant,
    required this.taskTime,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      description: json['description'],
      plant: Plant.fromJson(json['plant']),
      taskTime: json['taskTime'] is String
          ? int.parse(json['taskTime'])
          : json['taskTime'],
    );
  }

    static List<TaskModel> taskFromJson(List taskFromJson) {
    return taskFromJson.map((data) {
      return TaskModel.fromJson(data);
    }).toList();
  }
}

class Plant {
  final int id;
  final PlantDetails plantDetails;

  Plant({
    required this.id,
    required this.plantDetails,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      plantDetails: PlantDetails.fromJson(json['plant']),
    );
  }
}

class PlantDetails {
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

  PlantDetails({
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

  factory PlantDetails.fromJson(Map<String, dynamic> json) {
    return PlantDetails(
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
