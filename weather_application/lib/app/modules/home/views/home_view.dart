import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.put(HomeController());

  Widget buildWeatherCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Container(
        width: 150,
        height: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(title: const Text('Weather Web App'), backgroundColor:  Colors.lightBlue,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => controller.cityName.value = value,
                    onSubmitted: (_) => controller.fetchWeather(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: controller.fetchWeather,
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }
              if (controller.weatherData.isEmpty) {
                return const SizedBox.shrink();
              }
              return Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    buildWeatherCard('Temperature', '${controller.weatherData['temp']} °C'),
                    buildWeatherCard('Humidity', '${controller.weatherData['humidity']} %'),
                    buildWeatherCard('Condition', controller.weatherData['condition']),
                    buildWeatherCard('Wind Speed', '${controller.weatherData['wind']} kph'),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
