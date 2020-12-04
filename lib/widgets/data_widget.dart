import 'package:first_app/models/favorite_model.dart';
import 'package:first_app/models/weather_model.dart' show FormatedDate;
import 'package:first_app/providers/favorite_provider.dart';
import 'package:first_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataWidget extends StatelessWidget {
  FavoriteModel _favoriteModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<WeatherProvider>(
        builder: (context, weather, child) {
          if (weather.weatherModel == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              child: Column(
                children: [
                  Text(
                    weather.weatherModel.dt
                        .formatDate(weather.weatherModel.timezone),
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      weather.weatherModel.dt
                          .formatHour(weather.weatherModel.timezone),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<FavoriteProvider>(
                            builder: (context, favorite, child) {
                          int index = favorite.favorites.indexWhere((element) =>
                              element.latitude ==
                                  weather.weatherModel.coord.lat &&
                              element.longitude ==
                                  weather.weatherModel.coord.lon);
                          if (index >= 0) {
                            _favoriteModel = favorite.favorites[index];
                          }
                          if (_favoriteModel == null) {
                            return IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                FavoriteModel(
                                  name: weather.weatherModel.name,
                                  longitude: weather.weatherModel.coord.lon,
                                  latitude: weather.weatherModel.coord.lat,
                                );
                                if (weather.weatherModel != null) {
                                  _favoriteModel = await favorite.addToFavorite(
                                      FavoriteModel.fromWeatherModel(
                                          weather.weatherModel));
                                }
                              },
                            );
                          } else {
                            return IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  await context
                                      .read<FavoriteProvider>()
                                      .deleteFromFavorite(_favoriteModel);
                                  _favoriteModel = null;
                                });
                          }
                        }),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            weather.weatherModel.getName(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.network(weather.weatherModel.getIconPath()),
                  Text(
                    weather.weatherModel.getDescription(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                    child: Text(
                      '${weather.weatherModel.getTemperature()}\u00B0',
                      style: TextStyle(fontSize: 60, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
