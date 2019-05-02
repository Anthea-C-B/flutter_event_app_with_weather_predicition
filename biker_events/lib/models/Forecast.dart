import 'package:biker_events/models/weatherData.dart';
class ForecastData{
  final List list;
  ForecastData({this.list});
  factory ForecastData.fromJson(Map<String, dynamic> json){
    List list = new List();
    for(dynamic e in json['list']){
      weatherData w = new weatherData(
        date: DateTime.fromMillisecondsSinceEpoch(e['dt']*1000, isUtc: false),
        name: json['city']['name'],
        temp: e['main']['temp'],
        mainDt: e['weather'][0]['main'],
        icon: e['weather'][0]['icon']);
        list.add(w);
    }
    return ForecastData(list: list);
  }
}