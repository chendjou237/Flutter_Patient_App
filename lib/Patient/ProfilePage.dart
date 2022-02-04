import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/Patient/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:patient_app/data/data.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/models/user_model.dart' as My;
import 'package:patient_app/Patient/sidebar/sidebar.dart';
import 'package:patient_app/Patient/profile_clipper.dart';


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
          Map<String, dynamic> data =
              snapshot.data?.data() ;
          return Scaffold(
            key: _scaffoldKey,
            drawer: SideBar(),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                        child: AutoSizeText(
                          "Welcome Patient",
                          style: TextStyle(
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
                              AutoSizeText(
                                'first Name',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "Mr ${ data['firstName']}" , 
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'last Name',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['lastName']}",
                                style: TextStyle(
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
                              AutoSizeText(
                                'E - mail',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['email']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'cin',
                                style: TextStyle(
                                  color: Colors.black54,
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
                              AutoSizeText(
                                'home Phone number',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['homePhone']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'work phone number',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['workPhone']} ",
                                style: TextStyle(
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
                              AutoSizeText(
                                'street address 1',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['streetAddress1']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'street address 2',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['streetAddress2']} ",
                                style: TextStyle(
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
                              AutoSizeText(
                                'city',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['city']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'country',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['country']} ",
                                style: TextStyle(
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
                              AutoSizeText(
                                'hospital name',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['hospitalName']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'hospital address',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['hospitalAddress']} ",
                                style: TextStyle(
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
                              AutoSizeText(
                                'gender',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['gender']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              AutoSizeText(
                                'age',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              AutoSizeText(
                                "${data['age']} ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          AutoSizeText(
                            'marital status',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            "${data['marital']} ",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
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
        });
  }
}
