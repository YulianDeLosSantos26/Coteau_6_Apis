import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Clima extends StatefulWidget {
  const Clima({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<Clima> {
  String apiKey = 'c7fe3684376680471beb50748f88411f';
  String cityName = 'Santo Domingo';
  Map<String, dynamic>? weatherData;

  Future<void> fetchWeatherData() async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName,do&appid=$apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherData = data;
      });
    } else {
      setState(() {
        weatherData = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clima',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 109, 56, 255),
      ),
      body: Center(
        child: weatherData != null
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Ciudad: ${weatherData!['name']}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '🇩🇴 República Dominicana',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Descripción: ${weatherData!['weather'][0]['description']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Temperatura: ${((weatherData!['main']['temp'] - 273.15).toStringAsFixed(2))}°C',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sensación Térmica: ${((weatherData!['main']['feels_like'] - 273.15).toStringAsFixed(2))}°C',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Presión: ${weatherData!['main']['pressure']} hPa',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Humedad: ${weatherData!['main']['humidity']}%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Velocidad del Viento: ${weatherData!['wind']['speed']} m/s',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Cobertura de Nubes: ${weatherData!['clouds']['all']}%',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
