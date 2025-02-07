import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'HomePage.dart';
import 'Login.dart';
import 'SignUp.dart';
import 'Start.dart';
import 'otp_screen.dart';

var   usersRef = FirebaseFirestore.instance.collection("users");
final patientsRef = FirebaseFirestore.instance.collection("patients");
var   doctorsRef = FirebaseFirestore.instance.collection("Full_Profile_Doc");
var   docsRef = FirebaseFirestore.instance.collection("doctors");
var   appointementsRef = FirebaseFirestore.instance.collection("Appointments");
final diseasesRef = FirebaseFirestore.instance.collection("Disease");
final medTestRef = FirebaseFirestore.instance.collection("medical tests");
final radiologistsRef = FirebaseFirestore.instance.collection("radiologists");
final medicineRef = FirebaseFirestore.instance.collection("Diseases");
final analystRef = FirebaseFirestore.instance.collection("Analyst");
var   currentUser = FirebaseAuth.instance.currentUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
        "otp": (BuildContext context) => OtpScreen(),
      },
    );
  }
}


// intro methode resultat analyse discussion et conc ==> powerpoint ==> boxes

// split horizentale ==> less text ==> more schemas ==> pas d'encombrement

// self-contained