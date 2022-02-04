import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'Doctor/bloc.navigation_bloc/navigation_bloc.dart';
import 'SignUp.dart';
import 'package:patient_app/main.dart';

import 'otp_screen.dart';

final emailprovider = Provider<String>((ref) => '');
String loginpassword;

class Login extends StatefulHookWidget with NavigationStates {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  EmailAuth emailAuth;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        currentUser = user;
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  // Future<void> sendOtp() async {
  //   bool result = await emailAuth.sendOtp(recipientMail: _email, otpLength: 5);
  //   // Get.to(()=> OtpScreen());
  //   if (result) {
  //     // using a void function because i am using a
  //     // stateful widget and seting the state from here.
  //     return true;
  //     // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     //   return OtpScreen(email: _email);
  //     // }));
  //     // Navigator.pushReplacementNamed(context, "/otp",arguments: _email);

  //   }
  //   return false;
  // }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        // await sendOtp();
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        // Get.to(() => OtpScreen());
        loginpassword = _password;
        Navigator.pushReplacementNamed(context, "/otp");
      } catch (e) {
        // showError(e.message);
        print(e.message);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed("start"),
          ),
          title: Text("back"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  child: Image(
                    image: AssetImage("assets/login.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty) return 'Enter Email';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => _email = input),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.length < 6)
                                  return 'Provide Minimum 6 Character';
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              onSaved: (input) => _password = input),
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: login,
                          child: Text('LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Text('Create an Account?'),
                  onTap: navigateToSignUp,
                )
              ],
            ),
          ),
        ));
  }
}
