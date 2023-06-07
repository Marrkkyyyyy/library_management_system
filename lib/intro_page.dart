// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/login.dart';
import 'package:test/registration/student_registration.dart';

class introPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal.shade600),
      home: home(),
    );
  }
}

class home extends StatelessWidget {
  alertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      titlePadding: EdgeInsets.fromLTRB(25, 30, 25, 0),
      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 10),
      title: Text("Are you sure?",
          style: GoogleFonts.assistant(
            fontWeight: FontWeight.bold,
          )),
      content: Text("Do you want to exit the app?",
          style: GoogleFonts.assistant(
            fontSize: 17,
            height: 1.5,
            letterSpacing: 1.3,
          )),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(80, 40),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            exit(0);
          },
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(80, 40),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          child: Text(
            "No",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/a.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: WillPopScope(
          onWillPop: () {
            return alertDialog(context);
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Library Management System",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Text("Something very magical happens when you",
                              style: TextStyle(
                                color: Color.fromRGBO(194, 219, 255, 1),
                                letterSpacing: 1.2,
                              )),
                          SizedBox(
                            height: 3,
                          ),
                          Text("READ A GOOD BOOK.",
                              style: TextStyle(
                                  color: Color.fromRGBO(194, 219, 255, 1),
                                  letterSpacing: 1.2)),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                  ),
                  Center(
                    child: Column(children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 1),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * .88, 47),
                            backgroundColor: Color.fromARGB(255, 99, 62, 28),
                            primary: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Login()));
                        },
                        child: Text('Login',
                            style: TextStyle(
                                fontFamily: 'calibri', letterSpacing: 1.2)),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 1),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * .88, 47),
                            backgroundColor: Color.fromARGB(26, 60, 66, 64),
                            primary: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)))),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  studentRegistration()));
                        },
                        child: Text('Register',
                            style: TextStyle(
                                fontFamily: 'calibri', letterSpacing: 1.2)),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
