import 'package:drinks_app/screens/drink_detail.dart';
import 'package:drinks_app/services/favorites_service.dart';
import 'package:drinks_app/widgets/drink_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/drink.dart';

class DrinksListScreen extends StatefulWidget {
  final Function toggleTheme; // Funkcja do zmiany motywu

  DrinksListScreen({required this.toggleTheme});

  @override
  _DrinksListScreenState createState() => _DrinksListScreenState();
}

class _DrinksListScreenState extends State<DrinksListScreen> {
  late Future<List<Drink>> drinks; // Future przechowujące listę drinków
  List<String> favoriteDrinkIds = []; // Lista ulubionych ID drinków
  String searchQuery = ''; // Przechowuje zapytanie wyszukiwania
  bool showFavorites = false; // Flaga do decydowania, czy wyświetlać ulubione
  bool showSearch = false;

  @override
  void initState() {
    super.initState();
    _loadDrinks();
    _loadFavorites();
  }

  void _loadDrinks() {
    drinks = ApiService().fetchDrinks();
  }

  void _loadFavorites() async {
    final ids = await FavoritesService().loadFavorites();
    setState(() {
      favoriteDrinkIds = ids;
    });
  }

  void _toggleFavorite(String drinkId) async {
    await FavoritesService().toggleFavorite(
      drinkId,
    ); // Użycie toggleFavorite z FavoritesService
    _loadFavorites(); // Ponownie załaduj ulubione drinki
  }

  void _toggleShowFavorites() {
    setState(() {
      showFavorites = !showFavorites;
    });
  }

  void toggleSearch() {
    setState(() {
      showSearch = !showSearch;
    });
  }

  void _handleDrinkTap(String drinkId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrinkDetailScreen(drinkId: drinkId),
      ),
    );

    _loadFavorites(); // Przeładuj ulubione drinki, gdy status się zmieni
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: Text(
          'Cocktails',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ), // Tytuł aplikacji
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer, // Kolor AppBar
        actions: [
          IconButton(
            icon: Icon(
              showFavorites ? Icons.favorite : Icons.favorite_border,
            ), // Ikona serca
            onPressed: _toggleShowFavorites,
          ),
          IconButton(
            icon: Icon(Icons.contrast), // Ikona lupy
            onPressed: () {
              widget.toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.search), // Ikona lupy
            onPressed: () {
              toggleSearch();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Pasek wyszukiwania
            if (showSearch)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Type a drink name...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery =
                          value
                              .toLowerCase(); // Ustaw nową wartość dla zapytania
                    });
                  },
                ),
              ),
            // Widget FutureBuilder
            Expanded(
              child: FutureBuilder<List<Drink>>(
                future: drinks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Wystąpił błąd: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Brak dostępnych drinków.'));
                  }

                  // Filtruj drinki na podstawie zapytania i trybu (ulubione vs wszystkie)
                  final filteredDrinks =
                      (showFavorites
                              ? snapshot.data!
                                  .where(
                                    (drink) =>
                                        favoriteDrinkIds.contains(drink.id),
                                  )
                                  .toList()
                              : snapshot.data!)
                          .where(
                            (drink) =>
                                drink.name.toLowerCase().contains(searchQuery),
                          )
                          .toList();

                  // Budowanie listy drinków
                  return ListView.builder(
                    itemCount: filteredDrinks.length,
                    itemBuilder: (context, index) {
                      final drink = filteredDrinks[index];
                      final isFavorite = favoriteDrinkIds.contains(
                        drink.id,
                      ); // Sprawdza, czy drink jest ulubiony

                      return DrinkTile(
                        drink: drink,
                        isFavorite: isFavorite,
                        onFavoriteTap: () => _toggleFavorite(drink.id),
                        onTap: () => _handleDrinkTap(drink.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
