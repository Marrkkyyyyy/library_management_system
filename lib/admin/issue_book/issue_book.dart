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

class issueBook extends StatefulWidget {
  @override
  State<issueBook> createState() => _issueBookState();
}

class _issueBookState extends State<issueBook> {
  String? _designation_value;
  String? _strand_value;
  String _temp_strand_value = "";
  String? _string_strand_value;

  String? _course_value;
  String _temp_course_value = "";
  String? _string_course_value;

  String? _department_value;
  String _temp_department_value = "";
  String? _string_department_value;

  final _designation_list = [
    'Senior High',
    'College',
    'Faculty',
  ];

  List _strand_list = [];
  List _course_list = [];
  List _department_list = [];

  Future getStrand() async {
    String apiUrl = globals.endpoint + 'issue_book/display_degree.php';
    var _response =
        await http.post(Uri.parse(apiUrl), body: {'designation': "1"});
    var jsonData = jsonDecode(_response.body);
    setState(() {
      _strand_list = jsonData;
    });
  }

  Future getCourse() async {
    String apiUrl = globals.endpoint + 'issue_book/display_degree.php';
    var _response =
        await http.post(Uri.parse(apiUrl), body: {'designation': "2"});
    var jsonData = jsonDecode(_response.body);
    setState(() {
      _course_list = jsonData;
    });
  }

  Future getDepartment() async {
    String apiUrl = globals.endpoint + 'issue_book/display_degree.php';
    var _response =
        await http.post(Uri.parse(apiUrl), body: {'designation': "3"});
    var jsonData = jsonDecode(_response.body);
    setState(() {
      _department_list = jsonData;
    });
  }

  DropdownMenuItem<String> _designation(String block) {
    return DropdownMenuItem(value: block, child: Text(block));
  }

  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var userID = TextEditingController();
  var bookID = TextEditingController();
  var contact_no = TextEditingController();
  var department = TextEditingController();
  var course = TextEditingController();
  var strand = TextEditingController();
  var date = TextEditingController(text: '');

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  void initState() {
    date.text = today;
    getStrand();
    getCourse();
    getDepartment();
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

  void _issueBook() async {
    String apiUrl = globals.endpoint + "issue_book/issue_book.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "user_school_id": userID.text,
      "accession_no": bookID.text,
      "contact_no": contact_no.text,
      "issued_date": date.text,
      "designation": _designation_value.toString(),
      "degree": _designation_value.toString() == "Senior High"
          ? _strand_value.toString()
          : _designation_value.toString() == "College"
              ? _course_value.toString()
              : _department_value.toString()
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
    } else if (message == "NoAccessionNo") {
      Fluttertoast.showToast(
          msg: "No Accession Number Registered in Database",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message == "Max") {
      Fluttertoast.showToast(
          msg: "Student Reached Maximum Amount of Book to Borrowed",
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
              automaticallyImplyLeading: false,
              pinned: true,
              title: Text(
                "Issue Book",
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
                                    "Contact No.",
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
                                        controller: contact_no,
                                        autocorrect: false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter Contact No.',
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
                                                      vertical: 15),
                                              isDense: true,
                                              hintText: 'Enter Designation',
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
                                          items: _designation_list
                                              .map(_designation)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _designation_value = value;
                                            });
                                          },
                                        ),
                                      )
                                    ])),
                            _designation_value.toString() == "Senior High"
                                ? Container(
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Strand",
                                            style: textFieldTitle,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration:
                                                BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: .5,
                                                blurRadius: 3,
                                                offset: Offset(0, 3),
                                              )
                                            ]),
                                            child:
                                                DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 15),
                                                  isDense: true,
                                                  hintText: 'Enter Strand',
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
                                                          width: 1.5))),
                                              items: _strand_list.map((item) {
                                                _strand_value =
                                                    _temp_strand_value == ""
                                                        ? _strand_list[0]
                                                            ['degree']
                                                        : _string_strand_value;
                                                return DropdownMenuItem(
                                                  child:
                                                      new Text(item['degree']),
                                                  value:
                                                      item['degree'].toString(),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _string_strand_value = value!;
                                                  _temp_strand_value = value;
                                                });
                                              },
                                              value: _strand_value,
                                            ),
                                          )
                                        ]))
                                : _designation_value.toString() == "College"
                                    ? Container(
                                        padding: EdgeInsets.only(bottom: 30),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Course",
                                                style: textFieldTitle,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                decoration:
                                                    BoxDecoration(boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: .5,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 3),
                                                  )
                                                ]),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 15),
                                                      isDense: true,
                                                      hintText: 'Enter Course',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.grey),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              width: 1.5)),
                                                      focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              width: 1.5)),
                                                      border: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.grey.withOpacity(0.5),
                                                              width: 1.5))),
                                                  items:
                                                      _course_list.map((item) {
                                                    _course_value =
                                                        _temp_course_value == ""
                                                            ? _course_list[0]
                                                                ['degree']
                                                            : _string_course_value;
                                                    return DropdownMenuItem(
                                                      child: new Text(
                                                          item['degree']),
                                                      value: item['degree']
                                                          .toString(),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _string_course_value =
                                                          value!;
                                                      _temp_course_value =
                                                          value;
                                                    });
                                                  },
                                                  value: _course_value,
                                                ),
                                              )
                                            ]))
                                    : _designation_value == "Faculty"
                                        ? Container(
                                            padding:
                                                EdgeInsets.only(bottom: 30),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Department",
                                                    style: textFieldTitle,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: .5,
                                                            blurRadius: 3,
                                                            offset:
                                                                Offset(0, 3),
                                                          )
                                                        ]),
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 15),
                                                          isDense: true,
                                                          hintText:
                                                              'Enter Department',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  Colors.grey),
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  width: 1.5)),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  width: 1.5)),
                                                          border: UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5))),
                                                      items: _department_list
                                                          .map((item) {
                                                        _department_value =
                                                            _temp_department_value ==
                                                                    ""
                                                                ? _department_list[
                                                                    0]['degree']
                                                                : _string_department_value;
                                                        return DropdownMenuItem(
                                                          child: new Text(
                                                              item['degree']),
                                                          value: item['degree']
                                                              .toString(),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _string_department_value =
                                                              value!;
                                                          _temp_department_value =
                                                              value;
                                                        });
                                                      },
                                                      value: _department_value,
                                                    ),
                                                  )
                                                ]))
                                        : Container()
                          ],
                        ),
                      ),
                    )))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange.shade600,
          label: Text("Issue Book", style: GoogleFonts.ubuntu()),
          icon: Icon(Icons.check),
          onPressed: () {
            if (contact_no.text == "") {
              Fluttertoast.showToast(
                  msg: "Contact Number Cannot Be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (contact_no.text.length != 11) {
              Fluttertoast.showToast(
                  msg: "Invalid Number",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (contact_no.text.substring(0, 2) != "09") {
              Fluttertoast.showToast(
                  msg: "Invalid Number",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (this._designation_value == null) {
              Fluttertoast.showToast(
                  msg: "Designation Cannot Be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              _issueBook();
            }
          },
        ),
      ),
    );
  }
}
