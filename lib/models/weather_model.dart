import 'package:first_app/local_storage/user_preferences.dart';
import 'package:intl/intl.dart';

class WeatherModel {
  Coord coord;
  List<Weather> weather;
  Main main;
  Wind wind;
  int dt;
  Sys sys;
  String name;
  int timezone;

  WeatherModel({
    this.coord,
    this.weather,
    this.main,
    this.wind,
    this.dt,
    this.sys,
    this.name,
    this.timezone,
  });

  String getDescription() {
    return weather[0].description;
  }

  String getIconPath() {
    return 'https://openweathermap.org/img/wn/${weather[0].icon}@4x.png';
  }

  String getName() {
    return '$name, ${sys.country}';
  }

  String getTemperature() {
    if (UserPreferences().getMeasureUnit() == UserPreferences.kelvin) {
      return main.temp.round().toString();
    }
    if (UserPreferences().getMeasureUnit() == UserPreferences.fahrenheit) {
      double fahrenheit = (main.temp.round() * 9) / 5 - 459.67;
      return fahrenheit.round().toString();
    }
    if (UserPreferences().getMeasureUnit() == UserPreferences.celsius) {
      double celsius = main.temp.round() - 273.15;
      return celsius.round().toString();
    }
  }

  String getSpeedUnitMeasure() {
    if (UserPreferences().getSpeedUnit() == UserPreferences.unit_km) {
      double kilometres = wind.speed / 3.6;
      return '${kilometres.round().toString()} ${UserPreferences.unit_km}';
    }
    if (UserPreferences().getSpeedUnit() == UserPreferences.unit_mph) {
      double miles = wind.speed * 0.62;
      return '${miles.round().toString()} ${UserPreferences.unit_mph}';
    }
  }

  String getPressure() {
    if (UserPreferences().getPressureUnit() == UserPreferences.unit_hpa) {
      return '${main.pressure.round().toString()} ${UserPreferences.unit_hpa}';
    }
    if (UserPreferences().getPressureUnit() == UserPreferences.unit_psi) {
      double pressure = main.pressure * 1.024;
      return '${pressure.round()} ${UserPreferences.unit_psi}';
    }
  }

  String getDate() {
    var date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    DateFormat dateFormat = DateFormat.yMMMMd();
    return dateFormat.format(date);
  }

  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    name = json['name'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    data['dt'] = this.dt;
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['name'] = this.name;
    data['timezone'] = this.timezone;

    return data;
  }
}

class Coord {
  double lon;
  double lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = double.parse(json['lon'].toString());
    lat = double.parse(json['lat'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    main = json['main'].toString();
    description = json['description'].toString();
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = double.parse(json['temp'].toString());
    feelsLike = double.parse(json['feels_like'].toString());
    tempMin = double.parse(json['temp_min'].toString());
    tempMax = double.parse(json['temp_max'].toString());
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    return data;
  }
}

class Wind {
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = double.parse(json['speed'].toString());
    deg = int.parse(json['deg'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    return data;
  }
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

extension FormatedDate on int {
  String formatDate(int offset) {
    var date = DateTime.fromMillisecondsSinceEpoch((this + offset) * 1000);
    DateFormat dateFormat = DateFormat.yMMMMd();
    return dateFormat.format(date);
  }

  String formatHour(int offset) {
    var date = DateTime.fromMillisecondsSinceEpoch((this + offset) * 1000);
    DateFormat dateFormat = DateFormat.Hm();
    return dateFormat.format(date);
  }
}
