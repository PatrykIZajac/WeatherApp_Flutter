import 'package:first_app/models/weather_model.dart';

class FavoriteModel {
  int id;
  String name;
  double longitude;
  double latitude;

  FavoriteModel({this.id, this.name, this.longitude, this.latitude});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  static List<FavoriteModel> fromMap(List<Map<String, dynamic>> map) {
    return List.generate(map.length, (i) {
      return FavoriteModel(
        id: map[i]['id'],
        name: map[i]['name'],
        longitude: map[i]['longitude'],
        latitude: map[i]['latitude'],
      );
    });
  }

  static FavoriteModel fromWeatherModel(WeatherModel weatherModel) {
    return FavoriteModel(
      name: weatherModel.name,
      longitude: weatherModel.coord.lon,
      latitude: weatherModel.coord.lat,
    );
  }
}
