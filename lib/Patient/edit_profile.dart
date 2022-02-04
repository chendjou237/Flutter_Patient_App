import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Login.dart';
import '../SignUp.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';

class EditProfile extends StatefulWidget with NavigationStates {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isObscurePassword = true;
  Map label_vlaue = Map<String, String>();
  String sex = '';
  String marital = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        // ignore: missing_required_param
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 10, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/blue.png")))),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.blue),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              buildTextField("fname", "First Name", false),
              buildTextField("lname", "Last Name", false),
              buildTextField("hphone", "home phone number", true),
              buildTextField("wphone", "work Phone number", false),
              buildTextField("age", "Age", false),
              DropdownButton<String>(
                items: <String>['Male', 'Female', 'Undefine', 'Both']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {
                  sex = _;
                },
              ),
              buildTextField("cin", "CIN", false),
              buildTextField("saddress1", "street address1", false),
              buildTextField("saddress2", "street address2", false),
              buildTextField("city", "city", false),
              buildTextField("country", "country", false),
              DropdownButton<String>(
                items: <String>['Single', 'Couple', 'Divorce', 'Undefine']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {
                  marital = _;
                },
              ),
              buildTextField("hospitalname", "hospital name", false),
              buildTextField("hospitaladdress", "hospital address", false),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      patientsRef.doc(currentUser.uid).set({
                        "firstName": label_vlaue["fname"],
                        "lastName": label_vlaue["lname"],
                        "email": currentUser.email,
                        "password": loginpassword == ""? signuppassword: loginpassword,
                        "homePhone": label_vlaue["hphone"],
                        "streetAddress1": label_vlaue["saddress1"],
                        "streetAddress2": label_vlaue["saddress2"],
                        "city": label_vlaue["city"],
                        "country": label_vlaue["country"],
                        "hospitalName": label_vlaue["hospitalname"],
                        "hospitalAddress": label_vlaue["hospitaladdress"],
                        "workPhone": label_vlaue["wphone"],
                        "cin": label_vlaue["cin"],
                        "gender": sex,
                        "marital": marital,
                        "age": label_vlaue["age"],
                      }).then((value) => print(
                          "uploaded successfully user : ${currentUser.uid} ! ${label_vlaue["name"]}"));
                    },
                    child: Text("SAVE",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
          obscureText: isPasswordTextField ? isObscurePassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          isObscurePassword = !isObscurePassword;
                        });
                      },
                    )
                  : null,
              contentPadding: EdgeInsets.only(bottom: 5),
              labelText: placeholder,
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          onChanged: (value) async {
            print("The value entered is : $value");
            label_vlaue.update(
              labelText,
              (existingValue) => value,
              ifAbsent: () => value,
            );
            print("Current text value is : $labelText");
            print(label_vlaue);
          }),
    );
  }
}
