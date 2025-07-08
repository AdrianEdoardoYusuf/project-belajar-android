import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import 'package:geocoding/geocoding.dart';

class WeatherApiService {
  static Future<WeatherModel> fetchWeather({required double latitude, required double longitude}) async {
    // Open-Meteo API: https://open-meteo.com/en/docs
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true',
    );
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil data cuaca');
    }
    final data = json.decode(response.body);
    final current = data['current_weather'];
    // Ambil nama kota dari reverse geocoding
    String cityName = 'Lokasi Anda';
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        cityName = placemarks.first.locality ?? placemarks.first.name ?? cityName;
      }
    } catch (_) {}
    // Mapping kode cuaca ke deskripsi
    final description = _weatherCodeToDescription(current['weathercode']);
    return WeatherModel(
      cityName: cityName,
      temperature: (current['temperature'] as num).toDouble(),
      description: description,
    );
  }

  static String _weatherCodeToDescription(int code) {
    // Sederhana, bisa dikembangkan sesuai dokumentasi open-meteo
    switch (code) {
      case 0:
        return 'Cerah';
      case 1:
      case 2:
      case 3:
        return 'Sebagian berawan';
      case 45:
      case 48:
        return 'Berkabut';
      case 51:
      case 53:
      case 55:
        return 'Gerimis';
      case 61:
      case 63:
      case 65:
        return 'Hujan ringan';
      case 80:
      case 81:
      case 82:
        return 'Hujan lebat';
      default:
        return 'Cuaca tidak diketahui';
    }
  }
} 