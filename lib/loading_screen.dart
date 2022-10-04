// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables

import 'package:clima/location_screen.dart';
import 'package:clima/networking.dart';
import 'package:flutter/material.dart';
import 'location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

const apiKey = '1a857c13f49d79a539214ff8c32743d0';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

        var weatherData = networkHelper.getData();

        Navigator.push(this.context, MaterialPageRoute(builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        }));
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
