// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/api/user_previously_borrowed_books_search.dart';
import 'package:test/admin/model/returned_book_model.dart';
import 'package:test/user/previously_borrowed_books/previously_borrowed_books_details.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class previouslyBorrowedBooks extends StatefulWidget {
  final String userID;
  previouslyBorrowedBooks({required this.userID});
  @override
  State<previouslyBorrowedBooks> createState() =>
      _previouslyBorrowedBooksState();
}

class _previouslyBorrowedBooksState extends State<previouslyBorrowedBooks> {
  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    _getAllUserPreviouslyBorrowedBooks() async {
      String apiUrl =
          globals.endpoint + "user_display_previously_borrowed_books.php";
      var _response =
          await http.post(Uri.parse(apiUrl), body: {"userID": widget.userID});
      if (_response.statusCode == 200) {
        setStateIfMounted(() {});

        return json.decode(_response.body);
      }
    }

    @override
    void initState() {
      _getAllUserPreviouslyBorrowedBooks();
      super.initState();
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.teal.shade600,
            elevation: 0.0,
            title: Text(
              "Returned Books",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: FutureBuilder(
                future: _getAllUserPreviouslyBorrowedBooks(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List list = snapshot.data;

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        previouslyBorrowedBooksDetails(
                                          accession_no: list[index]
                                              ['accession_no'],
                                          title: list[index]['title'],
                                          issued_date: list[index]
                                              ['issued_date'],
                                          due_date: list[index]['due_date'],
                                          returned_date: list[index]
                                              ['returned_date'],
                                          overdue_days: int.parse(
                                              list[index]['overdue_days']),
                                          fines:
                                              int.parse(list[index]['fines']),
                                        )));
                              },
                              child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    dense: true,
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Text(list[index]['title'],
                                          style: GoogleFonts.assistant(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                    trailing: Container(
                                      child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 18),
                                    ),
                                  )),
                            );
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
