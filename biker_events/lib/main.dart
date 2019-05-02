import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:biker_events/models/firebaseUitility.dart';
import 'package:biker_events/models/alerts.dart';
import 'package:biker_events/register.dart';
import 'package:biker_events/home.dart';
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Main Method<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}
FirebaseLogin fb = new FirebaseLogin();
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Login and Register Pages<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
class Login extends StatefulWidget{
  @override
  loginState createState() => new loginState();
}
alertMessages alert = new alertMessages();
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Login Widgets<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
class loginState extends State<Login> {
  final lgnEmailController = new TextEditingController();
  final lgnPasswordController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    fb.isUserSignedIn().then((user){
      print ("Signed in " + user.toString());
      if(user != null){
        homePage();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Biker Events'),
        backgroundColor: Colors.red.shade900,
      ),
      body: new Material(
        child: new Container(
          padding: const EdgeInsets.all(30.0),
          color:Colors.white,
          child: new Container(
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new Text(
                    'Events',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.red.shade900,
                      fontFamily: "Fredericka the Great",
                      decoration: TextDecoration.underline
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 15.0)),
                  new TextFormField(
                    autofocus: true,
                    textAlign: TextAlign.left,
                    controller: lgnEmailController,
                    decoration:  new InputDecoration(
                      labelText: 'Username',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                      hintText: 'please enter your username',
                      fillColor: Colors.white,

                    ),
                    validator: (input){
                      if(input.length == 0){
                        return "Please enter a username";
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new TextFormField(
                    autofocus: true,
                    textAlign: TextAlign.left,
                    controller: lgnPasswordController,
                    obscureText: true,
                    decoration:  new InputDecoration(
                      labelText: 'Password',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                      hintText: 'please enter your password',
                      fillColor: Colors.white,
                    ),
                    validator: (input){
                      if(input.length == 0){
                        return "Please enter a password";
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 25.0)),
                  new Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 300,
                        height: 50,
                          child: RaisedButton(
                            color: Colors.red.shade900,
                            child: Text(
                              'Login',
                              style: new TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),
                            ),
                            textColor: Colors.white,
                            onPressed: (){
                              fb.handleEmailSignIn(lgnEmailController.text,lgnPasswordController.text,context).then((FirebaseUser user) => print(user))
                              .catchError((onError){
                              alert.alert(context,"Access Denied","Your login details were not found in our system.");
                              });
                            },
                          ),
                        ),
                    ],
                  ),   
                  new Padding(padding: EdgeInsets.only(top: 15.0)),
                  new Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 300,
                        height: 50,
                          child: RaisedButton(
                            color: Colors.blue.shade800,
                            child: Text(
                              'Login with Google',
                              style: new TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white
                              ),
                            ),
                            onPressed: (){
                              fb.handleGoogleSignIn(context).then((FirebaseUser user) => print(user))
                              .catchError((error){
                                alert.alert(context,"Access Denied","Google could not sign you in.");
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  new Padding(padding: EdgeInsets.only(top: 15.0)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        'Not a member?',
                        style: new TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      new ButtonTheme(
                        minWidth: 80,
                        height: 50,
                          child: FlatButton(
                            color: Colors.white,
                            child: Text(
                              'Sign up now.',
                              style: new TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Register()));
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              )
            )
          )
        )
      )
    );
  }
}
  