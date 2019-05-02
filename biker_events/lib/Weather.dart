import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:biker_events/models/weatherData.dart';

class Weather extends StatelessWidget{
  final weatherData weather;
  Weather({Key key, @required this.weather}):super(key:key);
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Text(weather.name, style: new TextStyle(color: Colors.black)),
        Text(weather.mainDt, style: new TextStyle(color: Colors.black, fontSize: 32.0)),
        Text('${weather.temp.toString()}°C',  style: new TextStyle(color: Colors.black)),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        Text(new DateFormat.yMMMd().format(weather.date), style: new TextStyle(color: Colors.black)),
        Text(new DateFormat.Hm().format(weather.date), style: new TextStyle(color: Colors.black)),
      ],
    );
  }
}