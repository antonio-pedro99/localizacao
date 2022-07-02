// ignore: constant_identifier_names
import 'dart:convert';

import 'package:my_location/address/model.dart';
import 'package:http/http.dart' as http;

const API_KEY = "26596f637c884370a827fbce54d9ddbc";
// ignore: constant_identifier_names
const API_URL = "https://api.geoapify.com/v1/geocode/autocomplete?text=";

class AddressSuggestions {
  static Future<List<AddressModel>> getSuggestions(String text) async {
    List<AddressModel> addresses = [];
    await http.get(Uri.parse("$API_URL$text&format=json&apiKey=$API_KEY")).then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        for (var json in result["results"]) {
          addresses.add(AddressModel.fromJson(json));
        }
      }
    });
    return addresses;
  }
}
