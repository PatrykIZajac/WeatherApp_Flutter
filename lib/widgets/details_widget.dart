import 'package:first_app/generated/l10n.dart';
import 'package:first_app/models/weather_model.dart' show FormatedDate;
import 'package:first_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class detailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);

    return Container(
      child: Consumer<WeatherProvider>(
        builder: (context, weather, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${delegate.WindText} ${weather.weatherModel.getSpeedUnitMeasure()}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${delegate.HumidityText} ${weather.weatherModel.main.humidity.toString()} %',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${delegate.PressureText} ${weather.weatherModel.getPressure()}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${delegate.SunsetText} ${weather.weatherModel.sys.sunset.formatHour(weather.weatherModel.timezone)}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
