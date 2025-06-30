import 'for_weather_app.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  const Page({super.key});
  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  String currentPlace = 'DAKSHINESWAR';
  late Future<dynamic> weather;
  @override
  void initState() {
    super.initState();
    fetchCoordinates('Dakshineswar');
    weather = getWeather();
  }

  final TextEditingController tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        actions: [
          IconButton(
            splashRadius: 16,
            padding: const EdgeInsets.all(10),
            onPressed: () {
              setState(() {
                weather = getWeather();
              });
            }, //updation
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Unexpected Error Occured\nPlease Check Network Connection\nHit Refresh\n\n\nIf Error Persists, Email Me\n\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  snapshot.error.toString(),
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w100),
                ),
              ],
            );
          }
          final data = snapshot.data!;
          final mTemp = data["current"]["temperature_2m"];
          final mTime = toForm(data["current"]["time"], 'jm');
          final typeicon = getWeatherType(
            data["current"]["weather_code"],
            DateTime.parse(data["current"]["time"]),
          );
          final type = typeicon["description"].toString();
          final icon = typeicon["image"]!;
          final hum = data["current"]["relative_humidity_2m"].toString();
          final win = data["current"]["wind_speed_10m"].toString();
          final pres = data["current"]["pressure_msl"].toString();
          final timezone = data["timezone_abbreviation"];
          final mApTemp = data["current"]["apparent_temperature"].toString();
          forecastCards.clear();
          dailyCards.clear();
          formForecastCards(data);
          formDailyCards(data);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Text(
                    currentPlace,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: tec,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(),
                              labelText: 'Enter Location',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            String location = convert(tec.text);
                            await fetchCoordinates(location);
                            setState(() {
                              currentPlace = place;
                              weather = getWeather();
                            });
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
            
                  const SizedBox(height: 20),
                  mainCard(
                    temp: mTemp,
                    weather: type,
                    icon: icon,
                    time: mTime,
                    zone: timezone,
                    appTemp: mApTemp,
                  ), //main card

                  const SizedBox(height: 20),
                  Text(
                    'Weather Forecast',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecastCards.length,
                      itemBuilder: (context, index) {
                        return forecastCards[index];
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'Additional Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      add(
                        type: 'Humidity',
                        value: '$hum %',
                        icon: Icons.water_drop,
                      ),
                      add(
                        type: 'Wind Speed',
                        value: '$win kmph',
                        icon: Icons.air,
                      ),
                      add(
                        type: 'Pressure',
                        value: '$pres hPa',
                        icon: Icons.beach_access,
                      ),
                    ],
                  ), //additinal

                  const SizedBox(height: 20),
                  Text(
                    'Daily Information',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 5),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: dailyCards,
                    ),
                  ),

                  const SizedBox(height: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
