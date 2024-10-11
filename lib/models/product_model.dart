class ProductModel {
  final int id;
  final String plantDiseaseName;
  final String medicineName;
  final String companyName;
  final String treatmentImage;

ProductModel({
    required this.id,
    required this.plantDiseaseName,
    required this.medicineName,
    required this.companyName,
    required this.treatmentImage,
  });

  static List <ProductModel> productFromJson(List treatmentFromJson) {
    return treatmentFromJson.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      plantDiseaseName: json['plantDiseaseName'] as String,
      medicineName: json['medicineName'] as String,
      companyName: json['companyName'] as String,
      treatmentImage: json['treatmentImage'] as String,
    );
  }
}
