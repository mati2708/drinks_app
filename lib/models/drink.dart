import 'ingredient.dart';

class Drink {
  final String id;
  final String name;
  final String category;
  final String glass;
  final String instructions;
  final String imageUrl;
  final bool alcoholic;
  final String createdAt;
  final String updatedAt;
  final List<Ingredient> ingredients;

  Drink({
    required this.id,
    required this.name,
    required this.category,
    required this.glass,
    required this.instructions,
    required this.imageUrl,
    required this.alcoholic,
    required this.createdAt,
    required this.updatedAt,
    required this.ingredients,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    var list = json['ingredients'] as List?;
    List<Ingredient> ingredientsList =
        (list ?? []).map((i) => Ingredient.fromJson(i)).toList();

    return Drink(
      id: json['id'].toString(),
      name: json['name'] ?? 'Brak nazwy',
      imageUrl: json['imageUrl'],
      category: json['category'] ?? 'Brak kategorii',
      glass: json['glass'],
      instructions: json['instructions'] ?? 'Brak instrukcji',
      alcoholic: json['alcoholic'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      ingredients: ingredientsList,
    );
  }
}
