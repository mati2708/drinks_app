import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {

  Future<List<String>> loadFavorites() async { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    return prefs.getStringList('favoriteDrinks') ?? [];
  } 

  Future<void> toggleFavorite(String drinkId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteDrinkIds = prefs.getStringList('favoriteDrinks') ?? [];

    if (favoriteDrinkIds.contains(drinkId)) {
      favoriteDrinkIds.remove(drinkId); 
    } else {
      favoriteDrinkIds.add(drinkId); 
    }

    await prefs.setStringList('favoriteDrinks', favoriteDrinkIds); 
  }
  
}