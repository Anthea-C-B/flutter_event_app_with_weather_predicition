import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:biker_events/home.dart';
import 'package:biker_events/main.dart';

class FirebaseLogin{

final GoogleSignIn gSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser authUser = null;

  Future<FirebaseUser> handleGoogleSignIn(BuildContext context) async{
    final GoogleSignInAccount googleUser = await gSignIn.signIn();
    final GoogleSignInAuthentication gAuth = await googleUser.authentication;
    final AuthCredential cred = GoogleAuthProvider.getCredential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );
    final FirebaseUser user = await auth.signInWithCredential(cred);
    if(user.uid != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()));
    }
    print ("signed in " + user.displayName);
    return user;
  } 

  Future<FirebaseUser> handleRegister(String name,String email, String password,
  String number,String country,String province,bool clubMember,String club,BuildContext context) async {
    authUser = await auth.createUserWithEmailAndPassword(email: email, password: password);
    if (authUser!= null){
      handleCreate(name, email, number, country, province, clubMember, club, authUser.uid,context);
    }
    assert (await authUser.getIdToken() != null);
    return authUser;
  }

  Future<FirebaseUser> handleEmailSignIn(String email, String password,BuildContext context) async{
    authUser = await auth.signInWithEmailAndPassword(email:email,password: password);
    if( authUser != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()));
    }
    assert( await authUser.getIdToken() != null);
    final FirebaseUser currUser = await auth.currentUser();
    assert(authUser.uid == currUser.uid);
    return authUser;
  }

  Future<FirebaseDatabase> handleCreate(String name,String email,
  String number,String country,String province,bool clubMember,String club,String uid,BuildContext context) async{
    await FirebaseDatabase.instance.reference().child('Users').child(uid)
    .set({
      'Name':name,
      'Email':email.trim(),
      'Contact_Number':number.trim(),
      'Country':country,
      'Province':province,
      'Is_Member':clubMember,
      'Club':club,
    }).then((FirebaseDatabase) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage())));
  }
  Future<void> signOut(BuildContext context) async{
    await auth.signOut();
    await gSignIn.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()));
  }
  
  Future<FirebaseUser> isUserSignedIn() async{
    if(auth.currentUser() != null){
      return auth.currentUser();
    }
  }
}