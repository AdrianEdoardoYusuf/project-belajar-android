// UI utama untuk menampilkan data cuaca
// TODO: Implementasikan tampilan cuaca yang menarik

import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_api_service.dart';
import '../services/location_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel? _weather;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final position = await LocationService.getCurrentLocation();
      final weather = await WeatherApiService.fetchWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      setState(() {
        _weather = weather;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $_error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchWeather,
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  )
                : _weather != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weather!.cityName,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_weather!.temperature.toStringAsFixed(1)}°C',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(_weather!.description),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _fetchWeather,
                            child: const Text('Refresh'),
                          ),
                        ],
                      )
                    : const Text('Tidak ada data cuaca'),
      ),
    );
  }
} 