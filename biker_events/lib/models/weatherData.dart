class weatherData{
  final DateTime date;
  final String name;
  final double temp;
  final String mainDt;
  final String icon;
  weatherData({this.date,this.name,this.temp,this.mainDt,this.icon});

  factory weatherData.fromJson(Map<String, dynamic> json){
    return weatherData(
      date: new DateTime.fromMicrosecondsSinceEpoch(json['dt'], isUtc:false),
      name:json['name'],
      temp:json['main'] ['temp'].toDouble(),
      mainDt: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}