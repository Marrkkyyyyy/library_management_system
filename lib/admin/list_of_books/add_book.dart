// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class addBook extends StatefulWidget {
  final String categoryID;
  addBook({required this.categoryID});
  @override
  State<addBook> createState() => _addBookState();
}

class _addBookState extends State<addBook> {
  String QrResult = "";

  Future<void> scanQR() async {
    String QrCodeScan;

    try {
      QrCodeScan = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR)
          .then((value) {
        if (value == "-1") {
          return "";
        } else {
          return accession_no.text = value;
        }
      });
    } on PlatformException {
      QrCodeScan = 'Failed to Scan QR Code.';
    }

    if (!mounted) return;
  }

  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var title = TextEditingController();
  var author = TextEditingController();
  var publisher = TextEditingController();
  var published_year = TextEditingController();
  var accession_no = TextEditingController(text: '');
  var notes = TextEditingController();

  void _addBook() async {
    String apiUrl = globals.endpoint + "list_of_books/add_book.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "title": title.text,
      "author": author.text,
      "publisher": publisher.text,
      "published_year": published_year.text,
      "accession_no": accession_no.text,
      "categoryID": widget.categoryID,
      "notes": notes.text,
    });
    var message = json.decode(_response.body);
    if (message == "Success") {
      Fluttertoast.showToast(
          msg: "Added Book Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context, rootNavigator: true).pop(context);
    } else if (message == "duplicateAccessionNo") {
      Fluttertoast.showToast(
          msg: "Accession Number is Already Taken",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error in Adding Book into Database!",
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
                "Add Book",
              ),
              centerTitle: true,
              backgroundColor: Colors.orange.shade600,
              elevation: 0.0,
            ),
            SliverFillRemaining(
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
                        autovalidateMode: AutovalidateMode.disabled,
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
                                        controller: accession_no,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  scanQR();
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
                                    "Title",
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
                                        textCapitalization:
                                            TextCapitalization.words,
                                        controller: title,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter Title',
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
                                    "Author",
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
                                        textCapitalization:
                                            TextCapitalization.words,
                                        controller: author,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter Author',
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
                                    "Publisher",
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
                                        textCapitalization:
                                            TextCapitalization.words,
                                        controller: publisher,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter Publisher',
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
                                    "Published Year",
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
                                        controller: published_year,
                                        autocorrect: false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 15),
                                            isDense: true,
                                            hintText: 'Enter Published Year',
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
                                    "Notes",
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
                                    child: Scrollbar(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        reverse: true,
                                        child: SizedBox(
                                          height: 87.0,
                                          child: TextFormField(
                                              controller: notes,
                                              maxLines: 250,
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 15),
                                                  isDense: true,
                                                  hintText: 'Enter Notes',
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
                                                          color: Colors.grey.withOpacity(0.5),
                                                          width: 1.5)))),
                                        ),
                                      ),
                                    ),
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
          label: Text("Add", style: GoogleFonts.ubuntu()),
          icon: Icon(Icons.add),
          onPressed: () {
            if (title.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Title Cannot be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (author.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Author Cannot be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (publisher.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "publisher Cannot be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (published_year.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Published Year Cannot be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (published_year.text.length != 4 ) {
              Fluttertoast.showToast(
                  msg: "Invalid Year",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (accession_no.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: "Accession Number Cannot be Null",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              _addBook();
            }
          },
        ),
      ),
    );
  }
}
