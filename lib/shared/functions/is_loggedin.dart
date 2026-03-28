import 'package:firebase_auth/firebase_auth.dart';

bool isLoggedin (){
  return  FirebaseAuth.instance.currentUser != null ;
}