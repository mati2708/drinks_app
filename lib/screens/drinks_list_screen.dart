import 'package:drinks_app/screens/drink_detail.dart';
import 'package:drinks_app/services/favorites_service.dart';
import 'package:drinks_app/widgets/drink_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';
import '../models/drink.dart';

class DrinksListScreen extends StatefulWidget {
  final Function toggleTheme; 

  DrinksListScreen({required this.toggleTheme});

  @override
  _DrinksListScreenState createState() => _DrinksListScreenState();
}

class _DrinksListScreenState extends State<DrinksListScreen> {
  late Future<List<Drink>> drinks;
  List<String> favoriteDrinkIds = [];
  String searchQuery = ''; 
  bool showFavorites = false; 
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
    ); 
    _loadFavorites(); 
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

    _loadFavorites(); 
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
        ), 
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer, 
        actions: [
          IconButton(
            icon: Icon(
              showFavorites ? Icons.favorite : Icons.favorite_border,
            ), // Ikona serca
            onPressed: _toggleShowFavorites,
          ),
          IconButton(
            icon: Icon(Icons.contrast),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.search), 
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
                              .toLowerCase(); 
                    });
                  },
                ),
              ),
            
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

                  
                  return ListView.builder(
                    itemCount: filteredDrinks.length,
                    itemBuilder: (context, index) {
                      final drink = filteredDrinks[index];
                      final isFavorite = favoriteDrinkIds.contains(
                        drink.id,
                      ); 

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
