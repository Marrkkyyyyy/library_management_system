import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/dashboard.dart';
import 'package:test/intro_page.dart';

import 'package:test/login_components/curved-left-shadow.dart';
import 'package:test/login_components/curved-left.dart';
import 'package:test/login_components/curved-right-shadow.dart';
import 'package:test/login_components/curved-right.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test/user/user_dashboard.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();

  void _login() async {
    String apiUrl = globals.endpoint + "user_login.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "email": email.text,
      "password": password.text,
    });
    var jsonData = json.decode(_response.body);
    if (jsonData['message'] == "SuccessAdmin") {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => adminDashboard(
                adminID: jsonData['adminID'],
                first_name: jsonData['first_name'],
                last_name: jsonData['last_name'],
                middle_name: jsonData['middle_name'],
                email: jsonData['email'],
                password: jsonData['password'],
              )));
    } else if (jsonData['message'] == "SuccessStudent") {
      globals.userID = jsonData['userID'];
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => userDashboard(
                userID: jsonData['userID'],
                first_name: jsonData['first_name'],
                last_name: jsonData['last_name'],
                middle_name: jsonData['middle_name'],
                email: jsonData['email'],
                password: jsonData['password'],
              )));
    } else if (jsonData['message'] == "NotRegistered") {
      Fluttertoast.showToast(
          msg: "Email Not Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Incorrect Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) => home()));
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
                  Positioned(top: 0, left: 0, child: CurvedLeft()),
                  Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
                  Positioned(bottom: 0, left: 0, child: CurvedRight()),
                  Container(
                    padding: EdgeInsets.only(top: 150),
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: [
                              Image.asset('images/logo.png'),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Welcome Back!",
                                style: GoogleFonts.ubuntu(
                                    letterSpacing: 1.4,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87),
                              ),
                              Text(
                                "Login to your Account!",
                                style: GoogleFonts.assistant(
                                  fontSize: 15.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 150.0,
                              padding: const EdgeInsets.only(left: 10.0),
                              margin: const EdgeInsets.only(right: 40.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 20.0,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(90.0),
                                  bottomRight: Radius.circular(90.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    controller: email,
                                    style: const TextStyle(fontSize: 22.0),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                      ),
                                      icon: const Icon(
                                        Icons.person_outline,
                                        size: 26.0,
                                      ),
                                      hintText: "Email Address",
                                      hintStyle:
                                          GoogleFonts.assistant(fontSize: 19),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: password,
                                    obscureText: true,
                                    style: const TextStyle(fontSize: 22.0),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                      ),
                                      icon: const Icon(
                                        Icons.lock_outline,
                                        size: 26.0,
                                      ),
                                      hintText: "Password",
                                      hintStyle:
                                          GoogleFonts.assistant(fontSize: 19),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 10,
                              child: InkWell(
                                onTap: () {
                                  _login();
                                  // if (email.text == "") {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Email is Empty",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       gravity: ToastGravity.BOTTOM,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Colors.red,
                                  //       textColor: Colors.white,
                                  //       fontSize: 16.0);
                                  // } else if (password.text == "") {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Password is Empty",
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       gravity: ToastGravity.BOTTOM,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Colors.red,
                                  //       textColor: Colors.white,
                                  //       fontSize: 16.0);
                                  // } else {
                                  //   _login();
                                  // }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(94, 201, 202, 1.0),
                                        Color.fromRGBO(119, 235, 159, 1.0),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10.0,
                                      )
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
