import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const apiKey = 'f77aadca1926d4ab3f228e5d38c9c085';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return FontAwesomeIcons.boltLightning;
    } else if (condition < 400) {
      return FontAwesomeIcons.tint;
    } else if (condition < 600) {
      return FontAwesomeIcons.cloudRain;
    } else if (condition < 700) {
      return FontAwesomeIcons.snowflake;
    } else if (condition < 800) {
      return FontAwesomeIcons.reorder;
    } else if (condition == 800) {
      return FontAwesomeIcons.sun;
    } else if (condition <= 804) {
      return FontAwesomeIcons.cloud;
    } else {
      return FontAwesomeIcons.exclamation;;
    }
  }
}
