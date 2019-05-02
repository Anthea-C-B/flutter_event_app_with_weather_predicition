import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:biker_events/models/firebaseUitility.dart';
import 'package:biker_events/models/alerts.dart';

void main() {
  runApp(MaterialApp(
    home: Register(),
  ));
}
FirebaseLogin fb = new FirebaseLogin();
alertMessages alert = new alertMessages();

class Register extends StatefulWidget{
  @override
  registerState createState() => new registerState();
}

final regNameController = new TextEditingController(); // Name
  final regEmailController = new TextEditingController(); // Email
  final regContactNumberController = new TextEditingController();// Contact Number
  final regPasswordOneController = new TextEditingController(); //Password
  final regConfirmPasswordController = new TextEditingController(); //Password confirm
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Gender>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  String genderSelect ="";
class registerState extends State<Register> {
  bool isChecked = false;
  int genderChoice = 0;
  String countryChoice;
  String provinceChoice;
  String clubChoice;
  void handleGenderChoice(int val){
    setState(() {
      genderChoice = val;
      if(val == 0){
        genderSelect = "Female";
      }else{
        genderSelect = "Male";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Events'),
        backgroundColor: Colors.red.shade900,
      ),
      body: new SingleChildScrollView(
        child: new Container(
          padding: const EdgeInsets.all(30.0),
          color:Colors.white,
          child: new Container(
            child: new Center(
              child: new Column(
                children: <Widget>[
                    
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.red.shade900,
                      fontFamily: "Fredericka the Great",
                      decoration: TextDecoration.underline
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new TextFormField(
                    autofocus: true,
                    textAlign: TextAlign.left,
                    decoration:  new InputDecoration(
                      labelText: 'Name',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                      hintText: 'please enter your first and last name',
                      hintStyle: new TextStyle(
                        fontSize: 15
                      ),
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.deepPurple.shade900,
                        size: 15,
                      ),
                      fillColor: Colors.white,
                    ),
                    controller: regNameController,
                    validator: (input){
                      if(input.length == 0){
                        return "please enter your first name!";
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),               
                  new TextFormField(
                    textAlign: TextAlign.left,
                    controller: regEmailController,
                    decoration:  new InputDecoration(
                      labelText: 'Email',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                      hintText: 'please enter your email address',
                      hintStyle: new TextStyle(
                        fontSize: 15
                      ),
                      icon: Icon(
                        Icons.email,
                        color: Colors.deepPurple.shade900,
                        size: 15,
                      ),
                      fillColor: Colors.white,
                    ),
                    validator: (input){
                      if(input.length == 0){
                        return "please enter your email address";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new TextFormField(
                    textAlign: TextAlign.left,
                    controller: regContactNumberController,
                    decoration:  new InputDecoration(
                      labelText: 'Contact Number',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                      hintText: 'please enter your contact number',
                      hintStyle: new TextStyle(
                        fontSize: 15
                      ),
                      icon: Icon(
                        Icons.add_call,
                        color: Colors.deepPurple.shade900,
                        size: 15,
                      ),
                      fillColor: Colors.white,
                    ),
                    validator: (input){
                      if(input.length == 0){
                        return "please enter your contact number";
                      }
                    },
                    keyboardType: TextInputType.phone,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ), 
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new Row(
                    children: <Widget>[
                      Icon(
                        Icons.group,
                        color: Colors.deepPurple.shade900,
                        size: 15,
                      ),
                      new Padding(padding: EdgeInsets.only(right: 15.0)),
                      new Text(
                        'Gender',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey.shade600
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Female',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey.shade600
                        ),
                      ),
                      Radio(
                        value: 0,
                        groupValue: genderChoice,
                        onChanged: handleGenderChoice,
                      ),
                      Text(
                        'Male',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey.shade600
                        ),
                      ),
                      Radio(
                        value: 1,
                        groupValue: genderChoice,
                        onChanged: handleGenderChoice,
                      )
                    ],
                  ),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Row(
                    children: <Widget>[
                      Icon(
                        Icons.explore,
                        color: Colors.deepPurple.shade900,
                        size: 15,
                      ),
                      new Padding(padding: EdgeInsets.only(right: 15.0)),
                      new Text(
                        'Location',
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey.shade600
                        ),
                      ),
                    ],
                  ),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Country:'
                      ),
                      new Padding(padding: EdgeInsets.only(right: 15.0)),
                      new DropdownButton <String>(
                        hint: new Text(
                          '- Please select a Country -',
                          style: new TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                          ),
                        ),
                        value: countryChoice,
                        items: <String>['South Africa','United Kingdom','Australia'].map(
                          (String value){
                            return new DropdownMenuItem <String>(
                              value: value,
                              child: new Text(value),
                            );
                          }
                        ).toList(),
                        onChanged: (String country){
                          setState(() {
                            countryChoice = country; 
                          });
                        },
                        style: new TextStyle(
                          color: Colors.indigoAccent
                        ),
                      )
                    ],
                  ),
                   new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Province:'
                      ),
                      new Padding(padding: EdgeInsets.only(right: 15.0)),
                      new DropdownButton <String>(
                        hint: new Text(
                          '- Please select a Province -',
                          style: new TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                          ),
                        ),
                        value: provinceChoice,
                        items: <String>['KwaZulu-Natal','Gauteng','Freestate'].map(
                          (String value){
                            return new DropdownMenuItem <String>(
                              value: value,
                              child: new Text(value),
                            );
                          }
                        ).toList(),
                        onChanged: (String province){
                          setState(() {
                            provinceChoice = province; 
                          });
                        },
                        style: new TextStyle(
                          color: Colors.indigoAccent
                        ),
                        
                      )
                    ],
                  ),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Row(
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(right: 15.0)),
                      Text(
                        'Are you a member of a club?',
                        style: new TextStyle(
                          color: Colors.deepPurple.shade900,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool yes) {
                          setState(() {
                            isChecked = yes; 
                          });
                        },
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Clubs:'
                      ),
                      new Padding(padding: EdgeInsets.only(right: 30.0)),
                      new DropdownButton <String>(
                        hint: new Text(
                          '- Please select a club -',
                          style: new TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black
                          ),
                        ),
                        value: clubChoice,
                        items: <String>['Outreach','S.P.C.A','CHOC'].map(
                          (String value){
                            return new DropdownMenuItem <String>(
                              value: value,
                              child: new Text(value),
                            );
                          }
                        ).toList(),
                        onChanged: (String club){
                          setState(() {
                            clubChoice = club; 
                          });
                        },
                        style: new TextStyle(
                          color: Colors.indigoAccent
                        ),
                      )
                    ],
                  ), 
                  new TextFormField(
                    textAlign: TextAlign.left,
                    controller: regPasswordOneController,
                    obscureText: true,
                    decoration:  new InputDecoration(
                      labelText: 'New Password',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                      hintText: 'please enter your password',
                      hintStyle: new TextStyle(
                        fontSize: 15
                      ),
                      icon: Icon(
                        Icons.fiber_pin,
                        color: Colors.deepPurple.shade900,
                        size: 15,
                      ),
                      fillColor: Colors.white,
                    ),
                    validator: (input){
                      if(input.length == 0){
                        return "please enter your password";
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new TextFormField(
                    textAlign: TextAlign.left,
                    controller: regConfirmPasswordController,
                    obscureText: true,
                    decoration:  new InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                      hintText: 'please confirm your password',
                      hintStyle: new TextStyle(
                        fontSize: 15
                      ),
                      icon: Icon(
                        Icons.fiber_pin,
                        color: Colors.deepPurple.shade900,
                        size: 15,
                      ),
                      fillColor: Colors.white,
                    ),
                    validator: (input){
                      if(input.length == 0){
                        return "please confirm your password";
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)), 
                  new Row(
                    children: <Widget>[
                      new ButtonTheme(
                        minWidth: 300,
                        height: 50,
                          child: RaisedButton(
                            color: Colors.red.shade900,
                            child: Text(
                              'Sign Up',
                              style: new TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white
                              ),
                            ),
                            onPressed: (){
                              if(regPasswordOneController.text == regConfirmPasswordController.text){
                                fb.handleRegister(regNameController.text,
                                regEmailController.text,regConfirmPasswordController.text,
                                regContactNumberController.text,countryChoice,provinceChoice,
                                isChecked,clubChoice,context).then((FirebaseUser user) => print(user))
                               .catchError((e) => alert.alert(context, "Error Registration", e.toString()));
                               regNameController.clear();
                               regEmailController.clear();
                               regContactNumberController.clear();
                               regPasswordOneController.clear();
                               regConfirmPasswordController.clear();
                              }else{
                                alert.alert(context, "Password Error", "Your passwords did not match!");
                              }
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