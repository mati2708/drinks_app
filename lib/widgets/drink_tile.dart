import 'package:drinks_app/models/drink.dart';
import 'package:flutter/material.dart';

class DrinkTile extends StatelessWidget {
  const DrinkTile({
    super.key, 
    required this.drink,
    required this.isFavorite, 
    required this.onFavoriteTap,
    required this.onTap,
  });

  final Drink drink;
  final bool isFavorite;
  final Function() onFavoriteTap;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Zaokrąglone rogi zdjęcia
        child: Image.network(
          drink.imageUrl, // URL zdjęcia drinka
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(drink.name), // Wyświetlanie nazwy drinka
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border, // Ikona serca
          color:
              isFavorite
                  ? Theme.of(context).colorScheme.secondary
                  : null, // Kolor serca, jeśli jest ulubione
        ),
        onPressed: onFavoriteTap,
      ),
      onTap: onTap,
    );
  }
}
