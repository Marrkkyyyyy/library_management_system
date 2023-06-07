// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/login.dart';
import 'package:test/register_components/bezier_container.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class studentRegistration extends StatefulWidget {
  @override
  _studentRegistrationState createState() => _studentRegistrationState();
}

class _studentRegistrationState extends State<studentRegistration> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  void _studentRegistration() async {
    String apiUrl = globals.endpoint + "student_register.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "user_school_id": user_school_id.text,
      "middle_initial": middle_initial.text == ""
          ? ""
          : middle_initial.text.toUpperCase() + ".",
      "first_name": first_name.text,
      "last_name": last_name.text,
      "email": email.text,
      "password": password.text,
    });
    var message = json.decode(_response.body);
    if (message == "duplicateID") {
      Fluttertoast.showToast(
          msg: "School ID is Already Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message == "duplicateEmail") {
      Fluttertoast.showToast(
          msg: "Email Has Already Taken",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message == "Error") {
      Fluttertoast.showToast(
          msg: "Error in Registering User into Database!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Successfully Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        if (user_school_id.text == "") {
          Fluttertoast.showToast(
              msg: "School ID Cannot Be Null",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (first_name.text == "") {
          Fluttertoast.showToast(
              msg: "First Name Cannot Be Null",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (last_name.text == "") {
          Fluttertoast.showToast(
              msg: "Last Name Cannot Be Null",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (email.text == "") {
          Fluttertoast.showToast(
              msg: "Email Cannot Be Null",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (password.text == "") {
          Fluttertoast.showToast(
              msg: "Password Cannot Be Null",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (first_name.text
                .contains(RegExp(r'[0-9!@#$%^&*()_+=\[\]{};:"\\|,.<>\/?]')) ||
            middle_initial.text
                .contains(RegExp(r'[0-9!@#$%^&*()_+=\[\]{};:"\\|,.<>\/?]')) ||
            last_name.text
                .contains(RegExp(r'[0-9!@#$%^&*()_+=\[\]{};:"\\|,.<>\/?]'))) {
          Fluttertoast.showToast(
              msg: "Invalid Name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          _studentRegistration();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.teal.shade400, Colors.teal.shade600])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  var user_school_id = TextEditingController(text: '');
  var middle_initial = TextEditingController(text: '');
  var first_name = TextEditingController(text: '');
  var last_name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var password = TextEditingController(text: '');

  Future<void> scanUserQR() async {
    String UserQrCodeScan;

    try {
      UserQrCodeScan = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR)
          .then((value) {
        if (value == "-1") {
          return "";
        } else {
          return user_school_id.text = value;
        }
      });
    } on PlatformException {
      UserQrCodeScan = 'Failed to Scan QR Code.';
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .20,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .15),
                      Image.asset('images/logo.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Create your account, it's free",
                        style: GoogleFonts.assistant(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "School ID",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    controller: user_school_id,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              scanUserQR();
                                            },
                                            icon: Icon(
                                              Icons.qr_code_scanner_outlined,
                                              color: Colors.teal.shade600,
                                              size: 36,
                                            )),
                                        border: InputBorder.none,
                                        fillColor:
                                            Color.fromARGB(255, 238, 238, 238),
                                        filled: true))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Middle Initial",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(1),
                                    ],
                                    controller: middle_initial,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor:
                                            Color.fromARGB(255, 238, 238, 238),
                                        filled: true))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "First Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    controller: first_name,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor:
                                            Color.fromARGB(255, 238, 238, 238),
                                        filled: true))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Last Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    controller: last_name,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor:
                                            Color.fromARGB(255, 238, 238, 238),
                                        filled: true))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color.fromARGB(255, 238, 238, 238),
                                  filled: true))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color.fromARGB(255, 238, 238, 238),
                                  filled: true))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .14),
                    ],
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
