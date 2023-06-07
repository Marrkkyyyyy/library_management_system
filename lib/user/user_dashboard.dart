import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/login.dart';
import 'package:test/user/currently_issued_book/currently_issued_book.dart';
import 'package:test/user/drawer.dart';
import 'package:test/user/list_of_books/book_category.dart';
import 'package:test/user/previously_borrowed_books/previously_borrowed_books.dart';
import 'package:intl/intl.dart';
import 'package:test/globals.dart' as globals;

class userDashboard extends StatefulWidget {
  final String userID;
  final String first_name;
  final String last_name;
  final String middle_name;
  final String email;
  final String password;

  userDashboard(
      {required this.userID,
      required this.first_name,
      required this.last_name,
      required this.middle_name,
      required this.email,
      required this.password});
  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {});
      } else {
        return;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            style: TextStyle(color: Colors.teal.shade600, fontSize: 16),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(80, 40),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            globals.userID = "";
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Login()));
          },
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.teal.shade600, fontSize: 16),
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
    DateTime now = DateTime.now();

    String _currentDate = DateFormat('EEEE').format(now);
    String currentdate = DateFormat('d LLLL, y').format(now);
    String currenttime = DateFormat('- hh:mm: a -').format(now);

    return WillPopScope(
      onWillPop: () {
        return alertDialog(context);
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 242, 242),
        key: _globalKey,
        drawer: userDrawer(
          userID: widget.userID,
          first_name: widget.first_name,
          last_name: widget.last_name,
          middle_name: widget.middle_name,
          email: widget.email,
          password: widget.password,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .43,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: .5,
                        blurRadius: 1,
                        offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.teal.shade600,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Column(
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
                          top: MediaQuery.of(context).size.height * .042),
                      child: Column(
                        children: [
                          Image.asset('images/logo.png'),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            _currentDate.toUpperCase(),
                            style: GoogleFonts.archivoBlack(
                              fontSize: 41,
                              letterSpacing: 5,
                              color: Color.fromARGB(220, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            currentdate,
                            style: GoogleFonts.ubuntu(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(220, 255, 255, 255),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(currenttime,
                              style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(220, 255, 255, 255),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .15),
                child: Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              userBookCategory()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: .5,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        ],
                        color: Colors.teal.shade600,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * .8,
                        child: Center(
                          child: Text("List of Books",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              userCurrentlyIssuedBook(
                                userID: widget.userID,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: .5,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        ],
                        color: Colors.teal.shade600,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * .8,
                        child: Center(
                          child: Text("Currently Issued Books",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              previouslyBorrowedBooks(userID: widget.userID)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: .5,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        ],
                        color: Colors.teal.shade600,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * .8,
                        child: Center(
                          child: Text("Previously Borrowed Books",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}





  // @override
  // void initState() {
  //   // TODO: implement initState

  //   Timer.periodic(Duration(seconds: 1), (Timer t) {
  //     if (mounted) {
  //       setState(() {});
  //     } else {
  //       return;
  //     }
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   DateTime now = DateTime.now();

  //   String _currentDate = DateFormat('EEEE').format(now);
  //   String currentdate = DateFormat('d LLLL, y').format(now);
  //   String currenttime = DateFormat('- hh:mm: a -').format(now);

  //   return Scaffold(
  //       drawer: userDrawer(),
  //       appBar: AppBar(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(
  //             bottom: Radius.circular(20),
  //           ),
  //         ),
  //         centerTitle: true,
  //         backgroundColor: Colors.orange.shade600,
  //         elevation: 0.0,
  //         title: Text(
  //           "Dashboard",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //       body: Center(
  //         child: Column(children: [
  //           Expanded(
  //               flex: 2,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     _currentDate.toUpperCase(),
  //                     style: GoogleFonts.archivoBlack(
  //                       fontSize: 40,
  //                       letterSpacing: 5,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(
  //                     currentdate,
  //                     style: GoogleFonts.ubuntu(
  //                         fontSize: 18, fontWeight: FontWeight.w600),
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(currenttime,
  //                       style: GoogleFonts.ubuntu(
  //                           fontSize: 15, fontWeight: FontWeight.w600)),
  //                 ],
  //               )),
  //           Expanded(
  //               flex: 3,
  //               child: Column(
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (BuildContext context) =>
  //                               userBookCategory()));
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10.0),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             spreadRadius: .5,
  //                             blurRadius: 3,
  //                             offset: Offset(0, 3),
  //                           )
  //                         ],
  //                         color: Colors.orange.shade600,
  //                       ),
  //                       child: Container(
  //                         height: MediaQuery.of(context).size.height * .08,
  //                         width: MediaQuery.of(context).size.width * .8,
  //                         child: Center(
  //                           child: Text("List of Books",
  //                               style: GoogleFonts.ubuntu(
  //                                   fontSize: 18,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.white)),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (BuildContext context) =>
  //                               previouslyBorrowedBooks()));
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10.0),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             spreadRadius: .5,
  //                             blurRadius: 3,
  //                             offset: Offset(0, 3),
  //                           )
  //                         ],
  //                         color: Colors.orange.shade600,
  //                       ),
  //                       child: Container(
  //                         height: MediaQuery.of(context).size.height * .08,
  //                         width: MediaQuery.of(context).size.width * .8,
  //                         child: Center(
  //                           child: Text("Previously Borrowed Books",
  //                               style: GoogleFonts.ubuntu(
  //                                   fontSize: 18,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.white)),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.of(context).push(MaterialPageRoute(
  //                           builder: (BuildContext context) =>
  //                               userCurrentlyIssuedBook()));
  //                     },
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10.0),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.5),
  //                             spreadRadius: .5,
  //                             blurRadius: 3,
  //                             offset: Offset(0, 3),
  //                           )
  //                         ],
  //                         color: Colors.orange.shade600,
  //                       ),
  //                       child: Container(
  //                         height: MediaQuery.of(context).size.height * .08,
  //                         width: MediaQuery.of(context).size.width * .8,
  //                         child: Center(
  //                           child: Text("Currently Issued Books",
  //                               style: GoogleFonts.ubuntu(
  //                                   fontSize: 18,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.white)),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ))
  //         ]),
  //       ));
  // }












  // Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 _currentDate.toUpperCase(),
  //                                 style: GoogleFonts.archivoBlack(
  //                                   fontSize: 40,
  //                                   letterSpacing: 5,
  //                                 ),
  //                               ),
  //                               SizedBox(
  //                                 height: 5,
  //                               ),
  //                               Text(
  //                                 currentdate,
  //                                 style: GoogleFonts.ubuntu(
  //                                     fontSize: 18,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               SizedBox(
  //                                 height: 5,
  //                               ),
  //                               Text(currenttime,
  //                                   style: GoogleFonts.ubuntu(
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.w600)),
  //                             ],
  //                           )