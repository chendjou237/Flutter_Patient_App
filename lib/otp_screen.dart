import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({Key key,  this.email, }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  EmailAuth emailAuth;
  TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
  }

  Future<bool> verify()async {
    if (await emailAuth.validateOtp(
        recipientMail: widget.email,
        userOtp: _otpController.value.text)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //center form
    return Scaffold(
      body: Container(
        margin: new EdgeInsets.only(left: 30.0, right: 30.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Enter OTP",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            new TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(labelText: 'OTP'),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            new MaterialButton(
              height: 40.0,
              minWidth: 100.0,
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('Verify'),
              onPressed: ()async {
                if  (await verify())
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                else
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Invalid OTP"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
              },
            ),
          ],
        ),
      ),
    );
  }
}
