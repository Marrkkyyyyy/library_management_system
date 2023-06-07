// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/issue_request/issue_request.dart';
import 'package:test/admin/drawer.dart';
import 'package:test/admin/issue_book/issue_book.dart';
import 'package:test/admin/list_of_books/book_category.dart';
import 'package:test/admin/not_returned_books/not_returned_books.dart';
import 'package:test/admin/returned_books/returned_books_dashboard.dart';
import 'package:test/login.dart';

class adminDashboard extends StatefulWidget {
  final String adminID;
  final String first_name;
  final String last_name;
  final String middle_name;
  final String email;
  final String password;

  adminDashboard(
      {required this.adminID,
      required this.first_name,
      required this.last_name,
      required this.middle_name,
      required this.email,
      required this.password});
  @override
  State<adminDashboard> createState() => _adminDashboardState();
}

class _adminDashboardState extends State<adminDashboard> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

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
      content: Text("Do you want to logout?",
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
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(80, 40),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Login()));
          },
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 242, 242),
      key: _globalKey,
      drawer: adminDrawer(
        adminID: widget.adminID,
        first_name: widget.first_name,
        last_name: widget.last_name,
        middle_name: widget.middle_name,
        email: widget.email,
        password: widget.password,
      ),
      body: WillPopScope(
        onWillPop: () {
          return alertDialog(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Container(
                  height: MediaQuery.of(context).size.height * .28,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 144, 11),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))
                      // image: DecorationImage(
                      //   image: AssetImage("images/j.jpg"),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(16, 29, 0, 0),
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              _globalKey.currentState!.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 26,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15,
                            top: MediaQuery.of(context).size.height * .08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dashboard",
                                style: GoogleFonts.assistant(
                                    letterSpacing: .8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 33)),
                            Text("Welcome, " + widget.first_name,
                                style: GoogleFonts.assistant(
                                    letterSpacing: .8,
                                    color: Colors.white,
                                    fontSize: 22))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    issueBook()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: .5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .20,
                              width: MediaQuery.of(context).size.width * .40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(FontAwesomeIcons.users,
                                      color: Colors.blue, size: 65),
                                  SizedBox(height: 10),
                                  Text("Issue Book",
                                      style:
                                          GoogleFonts.assistant(fontSize: 17))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    issueRequest()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: .5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .20,
                              width: MediaQuery.of(context).size.width * .40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.forum_rounded,
                                      color: Colors.yellow, size: 65),
                                  SizedBox(height: 10),
                                  Text("Issue Request",
                                      style:
                                          GoogleFonts.assistant(fontSize: 17))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    returnedBooksDashboard()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: .5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .20,
                              width: MediaQuery.of(context).size.width * .40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.event_note_rounded,
                                      size: 65, color: Colors.orange),
                                  SizedBox(height: 10),
                                  Text("Returned Books",
                                      style:
                                          GoogleFonts.assistant(fontSize: 17))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    notReturnedBooks()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: .5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .20,
                              width: MediaQuery.of(context).size.width * .40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.verified_user_rounded,
                                      color: Colors.green, size: 65),
                                  SizedBox(height: 10),
                                  Text("Not Returned Books",
                                      style:
                                          GoogleFonts.assistant(fontSize: 17))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    bookCategory()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: .5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .20,
                              width: MediaQuery.of(context).size.width * .40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.layers_alt_fill,
                                      size: 65,
                                      color: Color.fromARGB(255, 51, 105, 133)),
                                  SizedBox(height: 10),
                                  Text("List of Books",
                                      style:
                                          GoogleFonts.assistant(fontSize: 17))
                                ],
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
    );
  }
}
