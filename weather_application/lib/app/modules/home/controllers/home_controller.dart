// lib/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var cityName = ''.obs;
  var isLoading = false.obs;
  var weatherData = {}.obs;

  Future<void> fetchWeather() async {
    if (cityName.value.isEmpty) return;
    isLoading.value = true;
    weatherData.value = {};

    const apiKey = '1f963741117b428fb0c154719252806';
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=${cityName.value}';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['error'] != null) {
        Get.snackbar("Error", data['error']['message']);
      } else {
        weatherData.value = {
          'temp': data['current']['temp_c'],
          'humidity': data['current']['humidity'],
          'condition': data['current']['condition']['text'],
          'wind': data['current']['wind_kph'],
        };
      }
    } catch (e) {
      Get.snackbar("Error", "Error fetching weather data");
    } finally {
      isLoading.value = false;

    }
  }
}