import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  var condition,humi,pres,speed,fl,visible,cloud,deg,temperature;
  IconData ico;
  String loc,weatherIcon,cityName,weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        loc='City not found!';
        temperature = 'null';
        ico = FontAwesomeIcons.exclamation;
        fl='null';
        condition='null';
        return;
      }
      var wId = weatherData['weather'][0]['id'];
      ico = weather.getWeatherIcon(wId);
      condition = capitalize(weatherData['weather'][0]['description']);
      loc = weatherData['name'];
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      humi = weatherData['main']['humidity'];
      pres = (weatherData['main']['pressure']).toStringAsFixed(0);
      speed = weatherData['wind']['speed'];
      fl = (weatherData['main']['feels_like']).toStringAsFixed(0);
      visible = (weatherData['visibility']/1000).toInt();
      cloud= weatherData['clouds']['all'];
      deg= weatherData['wind']['deg'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xff081B25),
      body: Container(
        height: size.height,
        width: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0F2027),
            Color(0xff203A43),
            Color(0xff2C5364),
          ],
        )),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.03, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        FontAwesomeIcons.locationArrow,
                        color: Color(0xff6A81A0),
                        size: 30.0,
                      ),
                    ),
                    Align(
                      child: Text(
                        DateFormat.MMMEd().format(DateTime.now()),
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        FontAwesomeIcons.search,
                        color: Color(0xff6A81A0),
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 0),
                child: Text(
                  '$loc',
                  style: kSmallTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 0),
                child: Text(
                  'Today', //day
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff6A81A0),
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Icon(
                        ico,
                        size: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  '$condition  •  Feels like $fl',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Nunito',
                    color: Color(0xff6A81A0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.03),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.05)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 33.33,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.water_drop_outlined,
                                    size: 25.0,
                                    color: Color(0xff6A81A0),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '$humi%',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 33.33,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.scale,
                                    size: 25.0,
                                    color: Color(0xff6A81A0),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '$pres hPa',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 33.33,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Icon(
                                      Icons.air,
                                      size: 25.0,
                                      color: Color(0xff6A81A0),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '$speed m/s',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                            color: Colors.white.withOpacity(0.1),
                          height: 1.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 33.33,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.eye,
                                    size: 25.0,
                                    color: Color(0xff6A81A0),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '$visible km',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 33.33,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.cloud,
                                    size: 25.0,
                                    color: Color(0xff6A81A0),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '$cloud%',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 33.33,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.compass,
                                    size: 25.0,
                                    color: Color(0xff6A81A0),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '$deg°',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
