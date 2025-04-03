import 'package:drinks_app/services/favorites_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/drink.dart';
import '../services/api_service.dart';

class DrinkDetailScreen extends StatefulWidget {
  final String drinkId;

  const DrinkDetailScreen({required this.drinkId, super.key});

  @override
  State<DrinkDetailScreen> createState() => _DrinkDetailScreenState();
}

class _DrinkDetailScreenState extends State<DrinkDetailScreen> {
  late Future<Drink> drink;
  List<String> favoriteDrinkIds = [];
  final FavoritesService favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    drink = ApiService().fetchDrinkDetails(widget.drinkId);
    _loadFavorites();
  }

  void _loadFavorites() async {
    final ids = await FavoritesService().loadFavorites();
    setState(() {
      favoriteDrinkIds = ids;
    });
  }

  void _toggleFavorite(String drinkId) async {
    await FavoritesService().toggleFavorite(drinkId);
    _loadFavorites();
  }

  Widget buildHeader(Drink drinkDetails) {
    final isFavorite = favoriteDrinkIds.contains(drinkDetails.id);

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(drinkDetails.imageUrl, height: 120),
          // czaisz? ;)tak
        ),
        SizedBox(width: 16),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        drinkDetails.name,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavorite
                                ? Theme.of(context).colorScheme.secondary
                                : null,
                      ),
                      onPressed: () {
                        _toggleFavorite(drinkDetails.id);
                      },
                    ),
                  ],
                ),
                Text(drinkDetails.category),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGlass(String glassType) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Icon(
            Icons.local_bar,
            color: Theme.of(context).colorScheme.primaryContainer,
            size: 18,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Glass',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              glassType,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildIngredients(List<dynamic> ingredients) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Icon(
            Icons.checklist,
            color: Theme.of(context).colorScheme.primaryContainer,
            size: 18,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingrediens:',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var ingredient in ingredients)
                  Row(
                    children: [
                      Icon(Icons.circle, size: 6),
                      SizedBox(width: 8),
                      Text(
                        '${ingredient.measure ?? ''}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        '${ingredient.name}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRecipe(String instructions) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Icon(
            Icons.list,
            color: Theme.of(context).colorScheme.primaryContainer,
            size: 18,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recipe:',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 5),
              Text(
                instructions,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drink Detail',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: FutureBuilder<Drink>(
        future: drink,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Wystąpił błąd: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Brak danych do wyświetlenia.'));
          }

          final drinkDetails = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    buildHeader(drinkDetails),
                    buildGlass(drinkDetails.glass),
                    buildIngredients(drinkDetails.ingredients),
                    buildRecipe(drinkDetails.instructions),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
