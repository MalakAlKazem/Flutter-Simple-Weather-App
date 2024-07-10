//
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_application/services/weather_service.dart';
import 'package:weather_application/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('6f473f5266b180a6d31573b43cad3963');
  Weather? _weather;

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'fog':
      case 'haze':
      case 'smoke':
      case 'dust':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather('Beirut', 'LB');
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_weather != null) ...[
              Text(_weather!.cityName),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            ] else ...[
              Text('Loading weather...'),
              CircularProgressIndicator(),
            ],
            Text('${_weather!.temperature.round()} °C'),
            Text(_weather!.mainCondition),
          ],
        ),
      ),
    );
  }
}
