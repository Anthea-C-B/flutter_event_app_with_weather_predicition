import 'package:flutter/material.dart';
import 'package:biker_events/Weather.dart';
import 'package:biker_events/WeatherItem.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:biker_events/models/Forecast.dart';
import 'package:biker_events/models/weatherData.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MaterialApp(
    home: weather(),
  ));
}

class weather extends StatefulWidget{
  @override
  MyApp createState() => new MyApp();
}

class MyApp extends State<weather>{
  bool isLoading = false;
  weatherData wd;
  ForecastData fd;
  Location myLoc = new Location();
  String err;
  @override
  void initState(){
    super.initState();
    print('hit weather');
    loadWeather();
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text(
            'Weather App Example',
          ),
        ),
        body: Center(
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: wd != null ? Weather(weather:wd): Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading ? CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: new AlwaysStoppedAnimation(Colors.white),
                      ):IconButton(
                        icon: new Icon(Icons.refresh),
                        tooltip: 'Refresh',
                        onPressed: () => null,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200.0,
                    child: fd != null ? ListView.builder(
                      itemCount: fd.list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) => WeatherItem(weather: fd.list.elementAt(index))
                    ):Container(),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  loadWeather() async{
    
    setState(() {
      isLoading = true; 
    });

    LocationData location;
    try{
      location = await myLoc.getLocation();
      err = null;
    } on PlatformException catch(ex){
      if(ex.code == 'PERMISSION_DENIED'){
        err = 'Permission denied';
      }else if(ex.code == 'PERMISSION_DENIED_NEVER_ASK'){
        err = 'Permission denied - please ask the user to enable it from the app settings';
      }else{
        print(ex.message.toString());
      }
    }

    if(location != null){
      final lat = location.latitude;
        print('latitude'+lat.toString());
        final lon = location.longitude;
        final weatherResponse = await http.get(
            'https://api.openweathermap.org/data/2.5/weather?APPID=8113f9acfb61e103479a73ee88df0ce5&lat=${lat
                .toString()}&lon=${lon.toString()}');
        final forecastResponse = await http.get(
            'https://api.openweathermap.org/data/2.5/forecast?APPID=8113f9acfb61e103479a73ee88df0ce5&lat=${lat
                .toString()}&lon=${lon.toString()}');
         //print('weather data' + jsonDecode(weatherResponse.body));

        if(weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200){
          return setState((){
            print(jsonDecode(weatherResponse.body));
            wd = new weatherData.fromJson(jsonDecode(weatherResponse.body));
            fd = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
            isLoading = false;
          });
        }
    }
    setState(() {
      isLoading = false; 
    });
  }
}