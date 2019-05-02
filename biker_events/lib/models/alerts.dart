import 'package:flutter/material.dart';
class alertMessages{
  Future<void> alert(BuildContext context,String heading,String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading),
          titleTextStyle: new TextStyle(
            color: Colors.red.shade800,
            fontWeight: FontWeight.w800,
            fontSize: 15
          ),
          content:  Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}