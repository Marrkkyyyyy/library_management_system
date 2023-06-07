// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/list_of_books/edit_book_details.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;

class bookDetails extends StatefulWidget {
  final String bookID;
  final String accession_no;
  final String title;
  final String author;
  final String publisher;
  final String published_year;
  final String category;
  final String availability;
  final String notes;

  bookDetails({
    required this.bookID,
    required this.accession_no,
    required this.title,
    required this.author,
    required this.publisher,
    required this.published_year,
    required this.category,
    required this.availability,
    required this.notes,
  });

  @override
  State<bookDetails> createState() => _bookDetailsState();
}

class _bookDetailsState extends State<bookDetails> {
  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  _deleteBook(BuildContext contextD) {
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      titlePadding: EdgeInsets.only(bottom: 5, left: 25, right: 25, top: 25),
      actionsPadding: EdgeInsets.only(
        bottom: 5,
        right: 10,
        top: 5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Text(
          "All records will also be deleted.\nAre you sure you want to continue?",
          style: TextStyle(color: Colors.black54)),
      title: Text("Deleting..."),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(50, 40),
            padding: EdgeInsets.symmetric(horizontal: 15),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.orange),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(50, 40),
            padding: EdgeInsets.symmetric(horizontal: 15),
          ),
          onPressed: () async {
            var url = globals.endpoint + "list_of_books/delete_book.php";
            http.post(Uri.parse(url), body: {'bookID': widget.bookID});
            Navigator.pop(context);
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Deleted Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          },
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.orange),
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
      backgroundColor: Colors.orange.shade600,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              "Book Details",
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              PopupMenuButton(
                  elevation: 2,
                  offset: Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  iconSize: 17,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          value: 0,
                          child: TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => editBook(
                                          bookID: widget.bookID,
                                          title: widget.title,
                                          author: widget.author,
                                          publisher: widget.publisher,
                                          published_year: widget.published_year,
                                          accession_no: widget.accession_no,
                                          notes: widget.notes,
                                        )));
                              },
                              icon: Icon(Icons.edit,
                                  color: Colors.orange.shade600),
                              label: Text("Edit",
                                  style: TextStyle(color: Colors.black)))),
                      PopupMenuItem(
                          value: 1,
                          child: TextButton.icon(
                              onPressed: () async {
                                Navigator.pop(context);
                                _deleteBook(context);
                              },
                              icon: Icon(Icons.delete,
                                  color: Colors.orange.shade600),
                              label: Text(
                                "Delete",
                                style: TextStyle(color: Colors.black),
                              ))),
                    ];
                  },
                  onSelected: (value) async {
                    if (value == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => editBook(
                                bookID: widget.bookID,
                                title: widget.title,
                                author: widget.author,
                                publisher: widget.publisher,
                                published_year: widget.published_year,
                                accession_no: widget.accession_no,
                                notes: widget.notes,
                              )));
                    } else if (value == 1) {
                      _deleteBook(context);
                    }
                  })
            ],
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Acession No.",
                                        style: textFieldTitle,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Availability",
                                        style: textFieldTitle,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                          child: Text(widget.availability,
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 16,
                                                  color: widget.availability ==
                                                          "Available"
                                                      ? Colors.green
                                                      : Colors.red)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
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
                                  width: MediaQuery.of(context).size.width * 1,
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
                                    child: Text(widget.title,
                                        style:
                                            GoogleFonts.ubuntu(fontSize: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
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
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: .5,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    child: Text(widget.author,
                                        style:
                                            GoogleFonts.ubuntu(fontSize: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
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
                                  width: MediaQuery.of(context).size.width * 1,
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
                                    child: Text(widget.publisher,
                                        style:
                                            GoogleFonts.ubuntu(fontSize: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
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
                                  width: MediaQuery.of(context).size.width * 1,
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
                                    child: Text(widget.published_year,
                                        style:
                                            GoogleFonts.ubuntu(fontSize: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Category",
                                  style: textFieldTitle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
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
                                    child: Text(widget.category,
                                        style:
                                            GoogleFonts.ubuntu(fontSize: 16)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget.notes == ""
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Notes",
                                        style: textFieldTitle,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            child: Container(
                                              height: 54,
                                              child: SingleChildScrollView(
                                                  child: Text(widget.notes,
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 16))),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
