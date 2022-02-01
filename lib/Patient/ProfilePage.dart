import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/Patient/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:patient_app/data/data.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/models/user_model.dart' as My;
import 'package:patient_app/Patient/sidebar/sidebar.dart';
import 'package:patient_app/Patient/profile_clipper.dart';
import 'package:patient_app/main.dart' as main;

class ProfilePage extends StatefulWidget with NavigationStates {
  final My.User user;

  ProfilePage({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _yourPostsPageController;
  PageController _favoritesPageController;
   var _name = "....";
  var _email = "....";
  var _cin = "....";
  var _desc = "....";
  var _phone = "....";
  var _age = "....";

  @override
  void initState() {
    super.initState();
    _yourPostsPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
    _favoritesPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: patientsRef.doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder: (context, snapshot) {
        Map<String, dynamic> data = snapshot.data?.data()  as Map<String, dynamic>;
        return Scaffold(
          key: _scaffoldKey,
          drawer: SideBar(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipPath(
                      clipper: ProfileClipper(),
                      child: Image(
                        height: 300.0,
                        width: double.infinity,
                        image: AssetImage('assets/doctors.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image(
                            height: 120.0,
                            width: 120.0,
                            image: AssetImage('assets/user0.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    main.currentUser.displayName ?? '',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ClipPath(
                            clipper: ProfileClipper(),
                            child: Image(
                              height: 300.0,
                              width: double.infinity,
                              image: AssetImage('assets/doctors.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 10.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image(
                                  height: 120.0,
                                  width: 120.0,
                                  image: AssetImage('assets/user0.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Welcome Patient",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "Mr ${data['name']}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'age',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "${data['age']}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'E - mail',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "$_email",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'cin',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "${data['cin']} ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Phone number',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "${data['phone']}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'gender',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                "${data['desc']} ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 30.0),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (BuildContext context) =>
                      //                 new EditProfile()));
                      //   },
                      //   child: Text("Edit Profile",
                      //       style: TextStyle(
                      //           fontSize: 15,
                      //           letterSpacing: 2,
                      //           color: Colors.white)),
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Colors.blue,
                      //       padding: EdgeInsets.symmetric(horizontal: 50),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20))),
                      // )
                    ],
                  ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     Column(),
                //     Column(),
                //   ],
                // ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        );
      }
    );
  }
}
