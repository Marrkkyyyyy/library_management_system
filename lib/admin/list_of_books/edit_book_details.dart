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

class editBook extends StatefulWidget {
  final String bookID;
  final String accession_no;
  final String title;
  final String author;
  final String publisher;
  final String published_year;
  final String notes;

  editBook({
    required this.bookID,
    required this.accession_no,
    required this.title,
    required this.author,
    required this.publisher,
    required this.published_year,
    required this.notes,
  });

  @override
  State<editBook> createState() => _editBookState();
}

class _editBookState extends State<editBook> {
  String QrResult = "";

  

  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var title = TextEditingController(text: '');
  var author = TextEditingController(text: '');
  var publisher = TextEditingController(text: '');
  var published_year = TextEditingController(text: '');

  var notes = TextEditingController(text: '');

  @override
  void initState() {
    title.text = widget.title;
    author.text = widget.author;
    publisher.text = widget.publisher;
    published_year.text = widget.published_year;

    notes.text = widget.notes;

    super.initState();
  }

  void _editBook() async {
    String apiUrl = globals.endpoint + "list_of_books/edit_book_details.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      'bookID': widget.bookID,
      'title': title.text,
      'author': author.text,
      'publisher': publisher.text,
      'published_year': published_year.text,

      'notes': notes.text,
    });
    var message = json.decode(_response.body);
    if (message == "Success") {
      Fluttertoast.showToast(
          msg: "Updated Book Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context, rootNavigator: true).pop(context);
      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "Error in Updating Book into Database!",
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
              title: Text(
                "Add Book",
              ),
              centerTitle: true,
              backgroundColor: Colors.orange.shade600,
              elevation: 0.0,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
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
                                          controller: title,
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 15),
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
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          width: 1.5)),
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey.withOpacity(0.5),
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
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 15),
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
                                                  borderSide:
                                                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5)))),
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
                                                      color: Colors.grey.withOpacity(0.5),
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
                                          scrollPadding:
                                              EdgeInsets.only(bottom: 260),
                                          controller: published_year,
                                          autocorrect: false,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 15),
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
                                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5)))),
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
                                                scrollPadding: EdgeInsets.only(
                                                    bottom: 100),
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
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors.grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                width: 1.5)),
                                                    focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey
                                                                .withOpacity(0.5),
                                                            width: 1.5)),
                                                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5)))),
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
                      ))
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange.shade600,
          label: Text("Save", style: GoogleFonts.ubuntu()),
          icon: Icon(Icons.save),
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
            } else if (published_year.text.length > 4) {
              Fluttertoast.showToast(
                  msg: "Invalid Year",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }  else {
              _editBook();
            }
          },
        ),
      ),
    );
  }
}
