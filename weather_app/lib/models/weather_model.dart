// Model data cuaca untuk Weather App
// TODO: Tambahkan field sesuai response API cuaca

class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    return WeatherModel(
      cityName: cityName,
      temperature: (json['temperature'] as num).toDouble(),
      description: json['weathercode_description'] as String,
    );
  }
} 