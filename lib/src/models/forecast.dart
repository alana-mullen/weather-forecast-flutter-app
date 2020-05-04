// To parse this JSON data, do
//
//     final forecast = forecastFromJson(jsonString);

import 'dart:convert';

Forecast forecastFromJson(String str) => Forecast.fromJson(json.decode(str));

class Forecast {
  final String cod;
  final double message;
  final int cnt;
  final List<ListElement> list;
  final City city;

  Forecast({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    cod: json["cod"] == null ? null : json["cod"],
    message: json["message"] == null ? null : json["message"].toDouble(),
    cnt: json["cnt"] == null ? null : json["cnt"],
    list: json["list"] == null ? null : List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
    country: json["country"] == null ? null : json["country"],
  );
}

class Coord {
  final double lat;
  final double lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
  );
}

class ListElement {
  final int dt;
  final MainClass main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final Sys sys;
  final DateTime dtTxt;
  final Rain rain;
  final Rain snow;

  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.sys,
    this.dtTxt,
    this.rain,
    this.snow,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json["dt"] == null ? null : json["dt"],
    main: json["main"] == null ? null : MainClass.fromJson(json["main"]),
    weather: json["weather"] == null ? null : List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
    wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
    sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
    dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
    snow: json["snow"] == null ? null : Rain.fromJson(json["snow"]),
  );
}

class Clouds {
  final int all;

  Clouds({
    this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"] == null ? null : json["all"],
  );
}

class MainClass {
  final double temp;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final double seaLevel;
  final double grndLevel;
  final int humidity;
  final double tempKf;
  final String tempInCelsius;

  MainClass({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
    this.tempInCelsius
  });

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: json["temp"] == null ? null : json["temp"].toDouble(),
    tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
    tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
    pressure: json["pressure"] == null ? null : json["pressure"].toDouble(),
    seaLevel: json["sea_level"] == null ? null : json["sea_level"].toDouble(),
    grndLevel: json["grnd_level"] == null ? null : json["grnd_level"].toDouble(),
    humidity: json["humidity"] == null ? null : json["humidity"],
    tempKf: json["temp_kf"] == null ? null : json["temp_kf"].toDouble(),
  );
}

class Rain {
  final double the3H;

  Rain({
    this.the3H,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the3H: json["3h"] == null ? null : json["3h"].toDouble(),
  );
}

class Sys {
  final Pod pod;

  Sys({
    this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: json["pod"] == null ? null : podValues.map[json["pod"]],
  );
}

enum Pod { D, N }

final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});

class Weather {
  final int id;
  final MainEnum main;
  final String description;
  final String icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"] == null ? null : json["id"],
    main: json["main"] == null ? null : mainEnumValues.map[json["main"]],
    description: json["description"] == null ? null : json["description"],
    icon: json["icon"] == null ? null : json["icon"],
  );
}

enum MainEnum { CLEAR, CLOUDS, RAIN }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS,
  "Rain": MainEnum.RAIN
});

class Wind {
  final double speed;
  final double deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"] == null ? null : json["speed"].toDouble(),
    deg: json["deg"] == null ? null : json["deg"].toDouble(),
  );
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
