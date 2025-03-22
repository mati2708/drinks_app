import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/drink.dart';

class ApiService {
  final String baseUrl = 'https://cocktails.solvro.pl/api/v1';

  Future<List<Drink>> fetchDrinks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cocktails'));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        List<dynamic> drinksList = body['data'];

        List<Drink> drinks = drinksList
          .map((dynamic value) => Drink.fromJson(value))
          .toList();

        return drinks;
      } else {
        throw Exception('Failed to load drinks');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Drink> fetchDrinkDetails(String drinkId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cocktails/$drinkId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        Map<String, dynamic> data = body['data'];

        return Drink.fromJson(data);
      } else {
        throw Exception('Failed to load drink details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}