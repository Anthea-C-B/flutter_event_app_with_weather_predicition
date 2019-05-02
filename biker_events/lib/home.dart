 import 'package:flutter/material.dart';
import 'package:biker_events/Weather.dart';
import 'package:biker_events/WeatherItem.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:biker_events/models/Forecast.dart';
import 'package:biker_events/models/weatherData.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:biker_events/models/firebaseUitility.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:biker_events/models/events.dart';
import 'package:biker_events/eventItems.dart';

void main() {
  runApp(MaterialApp(
    home: homePage(),
  ));
}

class homePage extends StatefulWidget{
  @override
  homeState createState() => new homeState();
}

//API KEY - 8113f9acfb61e103479a73ee88df0ce5
FirebaseLogin fb = new FirebaseLogin();



class homeState extends State<homePage>{
  bool isLoading = false;
  weatherData wd;
  ForecastData fd;
  events nwEvents;
  eventItems weekEvt;
  
  Location myLoc = new Location();
  String err;
  @override
  void initState(){
    super.initState();
    loadWeather();
    loadHotEvents();
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Events'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.face),
                onPressed: (){},
                ),
                IconButton(
                icon: Icon(Icons.star),
                onPressed: (){},
                ),
                IconButton(
                icon: Icon(Icons.rowing),
                onPressed: (){
                   fb.signOut(context);
                  },
                ),
            ],
            backgroundColor: Colors.red.shade900,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.whatshot),),
                Tab(icon: Icon(Icons.weekend),),
                Tab(icon: Icon(Icons.language),),
                Tab(icon: Icon(Icons.wb_sunny),),
                Tab(icon: Icon(Icons.trending_up),),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              new Row(
               children: <Widget>[
                 new FlatButton(
                   onPressed: (){
                    new Center(
                child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                //child: weekEvt != null ? eventItems(evt: weekEvt): Container(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: isLoading ? CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: new AlwaysStoppedAnimation(Colors.purple.shade800),
                                  ):IconButton(
                                    icon: new Icon(Icons.refresh),
                                    tooltip: 'Refresh',
                                    onPressed: () => loadHotEvents(),
                                    color: Colors.purple.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    );
                   },
                   child: Text(
                     'Test'
                   ),
                 )
               ],
              ),//Tab 1 - New rides
              Icon(Icons.filter_2),//Tab 2 - Weekend only
              Icon(Icons.filter_3),//Tab 3 - International Events
              new Center(
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
                              valueColor: new AlwaysStoppedAnimation(Colors.purple.shade800),
                            ):IconButton(
                              icon: new Icon(Icons.refresh),
                              tooltip: 'Refresh',
                              onPressed: () => loadWeather(),
                              color: Colors.purple.shade800,
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
              ),//Tab 4 - Weather Report
              Icon(Icons.filter_5),//Tab 5 - Specials
            ],
          ),
        ),
      ),
    );
  }

  loadHotEvents(){
    FirebaseDatabase.instance.reference().child("Events").once().then((DataSnapshot snapshot){
       var eveDt = new Map();
       eveDt['eventWeather'] = snapshot.value['eventWeather'];
       eveDt['eventLikes'] = snapshot.value['eventLikes'];
       eveDt['eventName'] = snapshot.value['eventName'];
       eveDt['eventStartTime'] = snapshot.value['eventStartTime'];
       eveDt['eventDate'] = snapshot.value['eventDate'];
       eveDt['eventFee'] = snapshot.value['eventFee'];
      nwEvents = new events.fromJson(eveDt);
      print('Data:' + snapshot.value.toString());
    });
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
