import 'dart:convert';
import 'package:first_app/models/weather_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherProvider extends ChangeNotifier {
  WeatherModel _weatherModel;

  WeatherModel get weatherModel => _weatherModel;

  getWeatherByCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getWeatherByCoords(position.latitude, position.longitude);
  }

  getWeatherByCoords(double latitude, double longitude) async {
    print("fetch data from API");
    final response = await http
        .get('https://api.openweathermap.org/data/2.5/weather?lat=$latitude'
            '&lon=$longitude&appid=b1d836a38e63c167fc976980e5902850');

    if (response.statusCode == 200) {
      _weatherModel = WeatherModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      throw Exception('no data');
    }
  }

  getWeatherByName(name) async {
    try {
      final response = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=b1d836a38e63c167fc976980e5902850');
      if (response.statusCode == 200) {
        _weatherModel = WeatherModel.fromJson(jsonDecode(response.body));
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
