// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:test/globals.dart' as globals;
import 'dart:convert';

class issueBookRequest extends StatefulWidget {
  final String issueRequestID;

  final String user_school_id;
  final String designation;
  final String degree;
  final String contact_no;

  final String accession_no;

  final String degreeID;
  final String userID;

  final String bookID;

  issueBookRequest({
    required this.issueRequestID,
    required this.user_school_id,
    required this.designation,
    required this.degree,
    required this.contact_no,
    required this.accession_no,
    required this.degreeID,
    required this.userID,
    required this.bookID,
  });
  @override
  State<issueBookRequest> createState() => _issueBookRequestState();
}

class _issueBookRequestState extends State<issueBookRequest> {
  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var userID = TextEditingController();

  var date = TextEditingController(text: '');

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  void initState() {
    date.text = today;
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

  void _issueRequest() async {
    String apiUrl =
        globals.endpoint + "issue_request/confirmation_issue_request.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "issueRequestID": widget.issueRequestID,
      "user_school_id": userID.text,
      "accession_no": widget.bookID,
      "degreeID": widget.degreeID,
      "designation": widget.designation,
      "contact_no": widget.contact_no,
      "issued_date": date.text,
    });
    var message = json.decode(_response.body);
    if (message == "Error") {
      Fluttertoast.showToast(
          msg: "Error in Issuing Book into Database!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message == "NoUserID") {
      Fluttertoast.showToast(
          msg: "No User ID Registered in Database",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message == "DoesNotMatch") {
      Fluttertoast.showToast(
          msg: "The User ID Doesn't Match of the Requested Book",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message == "NotAvailable") {
      Fluttertoast.showToast(
          msg: "This Book is Not Available",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Issue Book Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.of(context, rootNavigator: true).pop(context);
    }
  }

  bool isExpanded = false;
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
                "Issue Request Book",
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
                              padding: EdgeInsets.only(bottom: 20, top: 20),
                              child: ExpansionPanelList(
                                animationDuration: Duration(milliseconds: 500),
                                dividerColor: Colors.red,
                                expandedHeaderPadding:
                                    EdgeInsets.only(bottom: 0.0),
                                elevation: 1,
                                children: [
                                  ExpansionPanel(
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Borrower's Information",
                                                  style: GoogleFonts.ubuntu(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  )),
                                            ]),
                                      );
                                    },
                                    body: Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: 20, top: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Contact No.",
                                                  style: textFieldTitle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: .5,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                    child: Text(
                                                        widget.contact_no,
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                fontSize: 16)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Designation",
                                                  style: textFieldTitle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: .5,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                    child: Text(
                                                        widget.designation,
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                fontSize: 16)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Degree",
                                                  style: textFieldTitle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: .5,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                    child: Text(widget.degree,
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                fontSize: 16)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    isExpanded: isExpanded,
                                  )
                                ],
                                expansionCallback: (int item, bool status) {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
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
                                        MediaQuery.of(context).size.width * 1,
                                    decoration: BoxDecoration(
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      child: Text(widget.accession_no,
                                          style:
                                              GoogleFonts.ubuntu(fontSize: 16)),
                                    ),
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
                          ],
                        ),
                      ),
                    )))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange.shade600,
          label: Text("Issue Request", style: GoogleFonts.ubuntu()),
          icon: Icon(Icons.check),
          onPressed: () {
            if (userID.text == "") {
              Fluttertoast.showToast(
                  msg: "User ID Cannot Be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              _issueRequest();
            }
          },
        ),
      ),
    );
  }
}
