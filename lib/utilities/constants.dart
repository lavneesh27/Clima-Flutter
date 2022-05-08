import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontSize: 60.0,
);

const kSmallTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontSize: 25.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Nunito',
);

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    FontAwesomeIcons.building,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    fontFamily: 'Nunito',
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
