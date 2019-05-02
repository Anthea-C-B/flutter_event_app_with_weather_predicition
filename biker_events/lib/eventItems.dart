import 'package:flutter/material.dart';
import 'package:biker_events/models/events.dart';

class eventItems extends StatelessWidget{
  final events evt;
  eventItems({Key key, @required this.evt}):super(key:key);
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Text(evt.name, style: new TextStyle(color: Colors.black)),
        Text(evt.date, style: new TextStyle(color: Colors.black, fontSize: 32.0)),
        Text('R ${evt.fee.toString()}',  style: new TextStyle(color: Colors.black)),
        Text(evt.numOfLikes, style: new TextStyle(color: Colors.black)),
        Text(evt.startTme, style: new TextStyle(color: Colors.black)),
      ],
    );
  }
}