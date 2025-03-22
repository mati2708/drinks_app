class Ingredient {
  final String id;
  final String name;
  final String description;
  final bool alcohol;
  final String? type;
  final int? percentage;
  final String? imageUrl;
  final String createdAt;
  final String updatedAt;
  final String? measure;

  Ingredient({
    required this.id,
    required this.name,
    required this.description,
    required this.alcohol,
    this.type,
    this.percentage,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.measure,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'] ?? "", 
      alcohol: json['alcohol'] ?? false, 
      type: json['type'],  
      percentage: json['percentage'],  
      imageUrl: json['imageUrl'],  
      createdAt: json['createdAt'] ?? "", 
      updatedAt: json['updatedAt'] ?? "", 
      measure: json['measure'],  
    );
  }
}