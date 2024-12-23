import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model Weather
class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
    );
  }
}

// Service untuk Fetch Data Cuaca
class WeatherService {
  final String apiKey = 'd5448f69850d51c2c59b15d32e5afaad';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }
}

// Widget untuk Menampilkan Data Cuaca
class WeatherList extends StatelessWidget {
  final Weather weather;

  WeatherList({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.wb_sunny, size: 50, color: Colors.orange),
          title: Text(weather.cityName, style: TextStyle(fontSize: 20)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Temperature: ${weather.temperature}°C'),
              Text('Description: ${weather.description}'),
              Text('Humidity: ${weather.humidity}%'),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Utama (Home Screen)
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService weatherService = WeatherService();
  String city = 'Jakarta'; // Default city
  Weather? weather;
  final TextEditingController cityController = TextEditingController();

  // Daftar kota-kota populer di Asia
  List<String> cities = [
    'Jakarta', 'Tokyo', 'Seoul', 'Bangkok', 'Singapore', 'Kuala Lumpur', 
    'Manila', 'Ho Chi Minh City', 'Hanoi', 'Delhi', 'Mumbai', 'Chennai'
  ];

  Future<void> fetchWeather() async {
    try {
      final data = await weatherService.fetchWeather(city);
      setState(() {
        weather = Weather.fromJson(data);
      });
    } catch (e) {
      print(e);
      setState(() {
        weather = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  // Fungsi untuk Menangani Pencarian Kota
  void searchCity() {
    setState(() {
      city = cityController.text.isEmpty ? city : cityController.text;
      fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchWeather,
          ),
        ],
      ),
      body: Column(
        children: [
          // Dropdown untuk Memilih Kota
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: city,
              onChanged: (String? newCity) {
                setState(() {
                  city = newCity!;
                  fetchWeather();
                });
              },
              items: cities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Pencarian Kota Manual
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchCity,
                ),
              ),
            ),
          ),
          // Menampilkan Cuaca
          weather == null
              ? Center(child: CircularProgressIndicator())
              : WeatherList(weather: weather!),
        ],
      ),
    );
  }
}

// Fungsi Utama untuk Menjalankan Aplikasi
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
