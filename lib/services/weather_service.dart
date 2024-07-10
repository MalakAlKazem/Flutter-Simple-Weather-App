// import 'dart:convert';
// import 'package:weather_application/models/weather_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class WeatherService {
//   static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
//   final String apiKey;

//   WeatherService(this.apiKey);

//   Future<Weather> getWeather(String cityName) async {
//     final encodedCityName = Uri.encodeComponent(cityName);
//     final url = '$BASE_URL?q=$encodedCityName&appid=$apiKey';
//     print('Request URL: $url');

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       print('Weather data fetched successfully.');
//       return Weather.fromJson(jsonDecode(response.body));
//     } else {
//       print(
//           'Failed to fetch weather data. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       throw Exception('Failed to fetch weather data');
//     }
//   }

//   Future<String> getCurrentCity() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     String? city = placemarks[0].locality;
//     print('Current city: $city');
//     return city ?? "";
//   }
// }

import 'dart:convert';
import 'package:weather_application/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName, String countryCode) async {
    final encodedCityName = Uri.encodeComponent(cityName);
    final url = '$BASE_URL?q=$encodedCityName,$countryCode&appid=$apiKey';
    print('Request URL: $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Weather data fetched successfully.');
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to fetch weather data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch weather data');
    }
  }
}
