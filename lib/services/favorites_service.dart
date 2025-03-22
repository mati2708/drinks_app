import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {

  Future<List<String>> loadFavorites() async { // loadFavorite ?
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    return prefs.getStringList('favoriteDrinks') ?? [];
  } 

  Future<void> toggleFavorite(String drinkId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteDrinkIds = prefs.getStringList('favoriteDrinks') ?? [];

    if (favoriteDrinkIds.contains(drinkId)) {
      favoriteDrinkIds.remove(drinkId); // Usuń z ulubionych
    } else {
      favoriteDrinkIds.add(drinkId); // Dodaj do ulubionych
    }

    await prefs.setStringList('favoriteDrinks', favoriteDrinkIds); // Zapisz zmiany
  }
  
}