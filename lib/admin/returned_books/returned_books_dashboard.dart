// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/api/returned_books_search_api.dart';
import 'package:test/admin/model/returned_book_model.dart';
import 'package:test/admin/returned_books/return_book.dart';
import 'package:test/admin/returned_books/returned_book_details.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class returnedBooksDashboard extends StatefulWidget {
  @override
  State<returnedBooksDashboard> createState() => _returnedBooksDashboardState();
}

class _returnedBooksDashboardState extends State<returnedBooksDashboard> {
  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    _getAllReturnedBooks() async {
      String apiUrl =
          globals.endpoint + "returned_books/display_returned_books.php";
      var _response = await http.post(Uri.parse(apiUrl));
      if (_response.statusCode == 200) {
        setStateIfMounted(() {});

        return json.decode(_response.body);
      }
    }

    @override
    void initState() {
      _getAllReturnedBooks();
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
            backgroundColor: Colors.orange.shade600,
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
                future: _getAllReturnedBooks(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List list = snapshot.data;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        returnedBookDetails(
                                      book_status: list[index]['book_status'],
                                      first_name: list[index]['first_name'],
                                      last_name: list[index]['last_name'],
                                      middle_name: list[index]['middle_name'],
                                      title: list[index]['title'],
                                      user_school_id: list[index]
                                          ['user_school_id'],
                                      accession_no: list[index]['accession_no'],
                                      issued_date: list[index]['issued_date'],
                                      due_date: list[index]['due_date'],
                                      returned_date: list[index]
                                          ['returned_date'],
                                      overdue_days: list[index]['overdue_days'],
                                      fines: list[index]['fines'],
                                      designation: list[index]['designation'],
                                      degree: list[index]['degree'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    dense: true,
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Text(list[index]['title'],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.assistant(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    subtitle: Text(
                                        list[index]['user_school_id'],
                                        style:
                                            GoogleFonts.ubuntu(fontSize: 14)),
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => returnBook()));
          },
          backgroundColor: Colors.orange.shade600,
          child: Icon(
            Icons.add,
          )),
    );
  }
}
