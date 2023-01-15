import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _weatherData = "";
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            image: DecorationImage(
              image: NetworkImage("")
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "How is The Weather?",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSubmitted: (value) {
                  _fetchWeather(value);
                },
              ),
              SizedBox(height: 20.0),
              Text(
                _weatherData,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _fetchWeather(String city) async {
    var apiKey = "42b023f4dca8ab761d75bb6122472767";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    // Extract temperature from JSON data
    var temperature = jsonData['main']['temp'];

    // Convert temperature from Kelvin to Celsius
    temperature = temperature - 273.15;

    // Round temperature to the nearest integer
    int temperatureInt = temperature.round();

    // Set state
    setState(() {
      _weatherData = "$temperatureInt °C";
    });
  }
}