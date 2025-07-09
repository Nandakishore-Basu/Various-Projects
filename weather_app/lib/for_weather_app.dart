import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  return SizedBox(
    height: 260,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color.fromARGB(255, 173, 173, 132),
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      Text(type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Text(value.toString()),
    ],
  );
}

double lat = 22.6598, lon = 88.3623;

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
    var typeicon = getWeatherType(
      data["hourly"]["weather_code"][i],
      DateTime.parse(data["hourly"]["time"][i]),
    );
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
    final current =
        'temperature_2m,weather_code,relative_humidity_2m,wind_speed_10m,pressure_msl,apparent_temperature';
    final hourly = 'temperature_2m,weather_code,apparent_temperature';
    final daily =
        'temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,precipitation_sum';
    final apiWeather =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=$current&hourly=$hourly&daily=$daily&timezone=auto&timeformat=iso8601';
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

dailyCard({
  required String date,
  required String timeSet,
  required String tempMax,
  required String tempMin,
  required String appTempMax,
  required String appTempMin,
  required String timeRise,
  required String precSum,
  Color color = Colors.grey,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: color,
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(height: 10),
          Icon(CupertinoIcons.sunrise, color: Colors.white),
          Text('Sunrise : $timeRise', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 7),
          Icon(CupertinoIcons.sunset, color: Colors.white),
          Text('Sunset : $timeSet', style: TextStyle(color: Colors.white)),
          const SizedBox(height: 7),
          Icon(CupertinoIcons.thermometer_sun, color: Colors.white),
          Text(
            'Max Temperature : $tempMax °C',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 7),
          Icon(CupertinoIcons.thermometer, color: Colors.white),
          Text(
            'Min Temperature : $tempMin °C',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 7),
          Icon(CupertinoIcons.flame, color: Colors.white),
          Text(
            'Max Feel : $appTempMax °C',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 7),
          Icon(CupertinoIcons.snow, color: Colors.white),
          Text(
            'Min Feel : $appTempMin °C',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 7),
          Icon(CupertinoIcons.cloud_rain, color: Colors.white),
          Text(
            'Precipitation Sum : $precSum mm',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 5),
        ],
      ),
    ),
  );
}

List<Widget> dailyCards = [];
dynamic formDailyCards(data) {
  for (int i = 0; i < data["daily"]["time"].length; i++) {
    var date = toForm(data["daily"]["time"][i], 'dd.MM.yyyy');
    var tempMax = data["daily"]["temperature_2m_max"][i].toString();
    var tempMin = data["daily"]["temperature_2m_min"][i].toString();
    var appTempMax = data["daily"]["apparent_temperature_max"][i].toString();
    var appTempMin = data["daily"]["apparent_temperature_min"][i].toString();
    var timeSet = toForm(data["daily"]["sunset"][i], 'jm');
    var timeRise = toForm(data["daily"]["sunrise"][i], 'jm');
    var precSum = data["daily"]["precipitation_sum"][i].toString();
    var color = allotColour(i);
    dailyCards.add(
      dailyCard(
        color: color,
        precSum: precSum,
        date: date,
        timeRise: timeRise,
        timeSet: timeSet,
        tempMax: tempMax,
        tempMin: tempMin,
        appTempMax: appTempMax,
        appTempMin: appTempMin,
      ),
    );
  }
}

Color allotColour(int i) {
  // 0: Red, 1: Orange, 2: Yellow, 3: Green, 4: Blue, 5: Indigo, 6: Violet
  switch (i) {
    case 0:
      return Colors.red;
    case 1:
      return Colors.orange;
    case 2:
      return const Color.fromARGB(255, 225, 202, 1);
    case 3:
      return Colors.green;
    case 4:
      return Colors.blue;
    case 5:
      return Colors.indigo;
    case 6:
      return Colors.purple; // Violet
    default:
      return Colors.grey; // fallback for out-of-range
  }
}

getLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return await Geolocator.getCurrentPosition();
  }

  LocationPermission permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied.');
  }
  return await Geolocator.getCurrentPosition();
}