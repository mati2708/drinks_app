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
      description: json['description'] ?? "",  // Umożliwia domyślną wartość dla opisu
      alcohol: json['alcohol'] ?? false,  // Domyślna wartość dla alkoholu
      type: json['type'],  // Typ może być null
      percentage: json['percentage'],  // Procent może być null
      imageUrl: json['imageUrl'],  // URL zdjęcia może być null
      createdAt: json['createdAt'] ?? "",  // Domyślna wartość dla daty stworzenia
      updatedAt: json['updatedAt'] ?? "",  // Domyślna wartość dla daty aktualizacji
      measure: json['measure'],  // Miarę także można traktować jako optional
    );
  }
}