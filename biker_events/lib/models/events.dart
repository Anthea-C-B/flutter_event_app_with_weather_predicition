class events{
  final String date;
  final String name;
  final String weather;
  final String startTme;
  final String fee;
  final String img;
  final String numOfLikes;

  events({this.date,this.name,this.weather,this.startTme,this.fee,this.img,this.numOfLikes});

  factory events.fromJson(Map<dynamic, dynamic> json){
    return events(
      weather: json['eventWeather'],
      numOfLikes: json['eventLikes'],
      name: json['eventName'],
      startTme: json['eventStartTime'],
      date: json['eventDate'],
      fee: json['eventFee']
    );
  }
}