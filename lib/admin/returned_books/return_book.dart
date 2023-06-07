// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:test/admin/returned_books/returned_books_dashboard.dart';
import 'package:test/globals.dart' as globals;

class returnBook extends StatefulWidget {
  @override
  State<returnBook> createState() => _returnBookState();
}

class _returnBookState extends State<returnBook> {
  String? _value;
  final _book_status = [
    'Good',
    'Bad',
  ];
  DropdownMenuItem<String> buildMenuItem(String block) {
    return DropdownMenuItem(value: block, child: Text(block));
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var userID = TextEditingController(text: '');
  var bookID = TextEditingController(text: '');
  var return_date = TextEditingController(text: '');

  String today = DateFormat('MM/dd/yyyy').format(DateTime.now());
  @override
  void initState() {
    return_date.text = today;
    super.initState();
  }

  Future<void> scanUserQR() async {
    String UserQrCodeScan;

    try {
      UserQrCodeScan = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR)
          .then((value) {
        if (value == "-1") {
          return "";
        } else {
          return userID.text = value;
        }
      });
    } on PlatformException {
      UserQrCodeScan = 'Failed to Scan QR Code.';
    }

    if (!mounted) return;
  }

  Future<void> scanAccessionNoQR() async {
    String AccessionNoQrCodeScan;

    try {
      AccessionNoQrCodeScan = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR)
          .then((value) {
        if (value == "-1") {
          return "";
        } else {
          return bookID.text = value;
        }
      });
    } on PlatformException {
      AccessionNoQrCodeScan = 'Failed to Scan QR Code.';
    }

    if (!mounted) return;
  }

  void _returnBook() async {
    String apiUrl = globals.endpoint + "returned_books/return_book.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "book_status": _value.toString(),
      "user_school_id": userID.text,
      "accession_no": bookID.text,
      "returned_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });
    var jsonData = json.decode(_response.body);
    if (jsonData['message'] == "Error") {
      Fluttertoast.showToast(
          msg: "Error in Issuing Book into Database!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (jsonData['message'] == "NoUserIDRegistered") {
      Fluttertoast.showToast(
          msg: "No User ID Registered in Database",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (jsonData['message'] == "NoAccessionNoRegistered") {
      Fluttertoast.showToast(
          msg: "No Accession Number Registered in Database",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (jsonData['message'] == "noUserIDBorrowed") {
      Fluttertoast.showToast(
          msg: "This User Doesn't Borrowed Any Books",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (jsonData['message'] == "noAccesionNoBorrowed") {
      Fluttertoast.showToast(
          msg: "This Book Has Not Been Borrowed by the Student",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (jsonData['message'] == "DoesNotMatch") {
      Fluttertoast.showToast(
          msg: "The User ID and Accession Number Doesn't Match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Return Book Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      _borrowersInformation(context, jsonData['book_title'], jsonData['first_name'],
          jsonData['last_name'], jsonData['middle_name'], jsonData['fines']);
    }
  }

  _borrowersInformation(BuildContext context, String book_title, String first_name,
      String last_name, String middle_name, String fines) {
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(25, 25, 15, 10),
      contentPadding: EdgeInsets.fromLTRB(25, 0, 15, 0),
      actionsPadding: EdgeInsets.fromLTRB(0, 7, 15, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text("Borrower's Information",
          style: GoogleFonts.assistant(
            fontWeight: FontWeight.bold,
          )),
      content: Builder(
        builder: (context) {
          return Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: GoogleFonts.assistant(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 1.5,
                            letterSpacing: 1.3,
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          //                   <--- left side
                          color: Colors.black,
                          width: 1.0,
                        ))),
                        child: Text(
                            middle_name == ""
                                ? last_name + ", " + first_name
                                : last_name +
                                    ", " +
                                    first_name +
                                    " " +
                                    middle_name,
                            style: GoogleFonts.assistant(
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 1.3,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Borrowed Book",
                          style: GoogleFonts.assistant(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 1.5,
                            letterSpacing: 1.3,
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          //                   <--- left side
                          color: Colors.black,
                          width: 1.0,
                        ))),
                        child: Text(book_title,
                            style: GoogleFonts.assistant(
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 1.3,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fines",
                          style: GoogleFonts.assistant(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            height: 1.5,
                            letterSpacing: 1.3,
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          //                   <--- left side
                          color: Colors.black,
                          width: 1.0,
                        ))),
                        child: Text(fines,
                            style: GoogleFonts.assistant(
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 1.3,
                            )),
                      ),
                    ],
                  ),
                ],
              ));
        },
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(80, 40),
            backgroundColor: Colors.black87,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);

            Navigator.of(context, rootNavigator: true).pop(context);
          },
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: alert);
      },
    );
  }

  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.orange.shade600,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              title: Text(
                "Return Book",
              ),
              centerTitle: true,
              backgroundColor: Colors.orange.shade600,
              elevation: 0.0,
            ),
            SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                    height: MediaQuery.of(context).size.height * .90,
                    width: MediaQuery.of(context).size.width * 1,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 243, 243, 243),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Book Status",
                                        style: textFieldTitle,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: .5,
                                            blurRadius: 3,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 13),
                                              isDense: true,
                                              hintText: 'Enter Book Status',
                                              hintStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey),
                                              fillColor: Colors.white,
                                              filled: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .grey
                                                              .withOpacity(0.5),
                                                          width: 1.5)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          width: 1.5)),
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      width: 1.5))),
                                          items: _book_status
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              this._value = value;
                                            });
                                          },
                                        ),
                                      )
                                    ])),
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User ID",
                                    style: textFieldTitle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 80,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: .5,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                    child: TextFormField(
                                        controller: userID,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  scanUserQR();
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .qr_code_scanner_outlined,
                                                  color: Colors.orange.shade600,
                                                  size: 36,
                                                )),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter User ID',
                                            hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)))),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Accession No.",
                                    style: textFieldTitle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 80,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: .5,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                    child: TextFormField(
                                        controller: bookID,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  scanAccessionNoQR();
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .qr_code_scanner_outlined,
                                                  color: Colors.orange.shade600,
                                                  size: 36,
                                                )),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter Accession No.',
                                            hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)))),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Return Date",
                                    style: textFieldTitle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: .5,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                    child: TextFormField(
                                        enabled: false,
                                        controller: return_date,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter Return Date',
                                            hintStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.5)))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange.shade600,
          label: Text("Return", style: GoogleFonts.ubuntu()),
          icon: Icon(Icons.check),
          onPressed: () {
            if (this._value == null) {
              Fluttertoast.showToast(
                  msg: "Book Status Cannot Be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              _returnBook();
            }
          },
        ),
      ),
    );
  }
}
