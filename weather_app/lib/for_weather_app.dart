import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:weather_app/json_data.dart';

forecastCard({
  required var time,
  required var temp,
  required String icon,
  required String type,
  required String date,
  required String appTemp,
}) {
  return Card(
    color: Color.fromARGB(255, 104, 105, 101),
    elevation: 12,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(date),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5),
          Image.network(icon),
          const SizedBox(height: 5),
          Text(type),
          const SizedBox(height: 5),
          Text('${temp.toString()} °C'),
          Text('Feel : $appTemp °C'),
        ],
      ),
    ),
  );
}

mainCard({
  required var temp,
  required String weather,
  required String icon,
  required String time,
  required String zone,
  required String appTemp,
}) {
  return SizedBox(
    width: double.infinity,
    child: Card(
      color: Color.fromARGB(255, 136, 156, 230),
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('Updated : $time ($zone)'),
                Text(
                  '${temp.toString()} °C',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Feels Like : $appTemp °C',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Image.network(icon),
                SizedBox(height: 8),
                Text(
                  weather,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

add({
  String type = 'Unknown',
  var value = 'Unknown',
  IconData icon = Icons.not_interested,
}) {
  return Column(
    children: [
      Icon(icon, size: 50),
      Text(type, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(value.toString()),
    ],
  );
}

var lat = 22.6598, lon = 88.3623;

String place = 'DAKSHINESWAR';

Map<String, String> getWeatherType(int code, DateTime time) {
  var data = getJsonData();
  bool isDay = time.hour >= 6 && time.hour < 18;
  String timeKey = isDay ? 'day' : 'night';
  var weatherInfo = data[code.toString()][timeKey];
  return {
      'description': weatherInfo['description'],
      'image': weatherInfo['image'],
    };
}

List<Widget> forecastCards = [];
dynamic formForecastCards(data) {
  for (int i = 0; i <= 167; i++) {
    var time = toForm(data["hourly"]["time"][i], 'j');
    var date = toForm(data["hourly"]["time"][i].split('T')[0], 'dd.MM.yyyy');
    var temp = data["hourly"]["temperature_2m"][i];
    var typeicon = getWeatherType(data["hourly"]["weather_code"][i], DateTime.parse(data["hourly"]["time"][i]));
    var icon = typeicon["image"]!;
    var type = typeicon["description"]!;
    String appTemp = data["hourly"]["apparent_temperature"][i].toString();
    forecastCards.add(
      forecastCard(
        time: time,
        temp: temp,
        icon: icon,
        type: type,
        date: date,
        appTemp: appTemp,
      ),
    );
  }
}

fetchCoordinates(String location) async {
  final apiLocation =
      'https://nominatim.openstreetmap.org/search?q=$location&format=json';
  final urlLocation = Uri.parse(apiLocation);
  try {
    final response = await http.get(urlLocation);
    final data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      lat = double.parse(data[0]['lat']);
      lon = double.parse(data[0]['lon']);
      place = data[0]['name'].toUpperCase();
    } else {
      place = 'INVALID';
      location = 'DAKSHINESWAR';
    }
  } catch (e) {
    throw e.toString();
  }
}

Future<Map<String, dynamic>> getWeather() async {
  try {
    final apiWeather =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,weather_code,relative_humidity_2m,wind_speed_10m,pressure_msl,apparent_temperature&hourly=temperature_2m,weather_code,apparent_temperature&timezone=auto&timeformat=iso8601';
    final url = Uri.parse(apiWeather);
    final res = await http.get(url);
    final data = jsonDecode(res.body);
    return data;
  } catch (e) {
    throw e.toString();
  }
}

convert(String loc) {
  loc = loc.trim().replaceAll(' ', '+');
  return loc;
}

toForm(String date, String format) {
  var parsed = DateTime.parse(date);
  var formatted = DateFormat(format).format(parsed);
  return formatted;
}
