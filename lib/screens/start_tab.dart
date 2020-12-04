import 'package:first_app/providers/weather_provider.dart';
import 'package:first_app/widgets/data_widget.dart';
import 'package:first_app/widgets/details_widget.dart';
import 'package:first_app/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("BUILD");
    return Consumer<WeatherProvider>(
      builder: (context, weather, child) {
        if (weather.weatherModel == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              print("UPDATE from swipe to refresh");
              return await Provider.of<WeatherProvider>(context, listen: false)
                  .getWeatherByName(weather.weatherModel.name);
            },
            child: ListView(
              children: <Widget>[
                inputWidget(),
                DataWidget(),
                detailsWidget(),
              ],
            ),
          );
        }
      },
    );
  }
}
