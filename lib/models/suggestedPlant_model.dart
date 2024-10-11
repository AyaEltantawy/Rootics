class SuggestedPlantsModel {
  int? suggestedPlantId;
  String? name;
  String? image;
  String? description;

  SuggestedPlantsModel(
      {this.suggestedPlantId, required this.name,required this.image,required this.description});

  SuggestedPlantsModel.fromJson(Map<String, dynamic> json) {
    suggestedPlantId = json['suggestedPlantId'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  static List<SuggestedPlantsModel> suggestedPlantsFromJson(List allPlantsListFromJson) {
    //print(allPlantsListFromJson[0]);
    return allPlantsListFromJson.map((data) {
      //print(data);
      return SuggestedPlantsModel.fromJson(data);
    }).toList();
  }
}

