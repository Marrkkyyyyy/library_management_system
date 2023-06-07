import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:test/user/currently_issued_book/issued_book_details.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class userCurrentlyIssuedBook extends StatefulWidget {
  final String userID;
  userCurrentlyIssuedBook({required this.userID});
  @override
  State<userCurrentlyIssuedBook> createState() =>
      _userCurrentlyIssuedBookState();
}

class _userCurrentlyIssuedBookState extends State<userCurrentlyIssuedBook> {
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    _getAllUserCurrentlyIssuedBook() async {
      String apiUrl =
          globals.endpoint + "user_display_currently_issued_book.php";
      var _response = await http.post(Uri.parse(apiUrl), body: {"userID": widget.userID});
      if (_response.statusCode == 200) {
        setStateIfMounted(() {});

        return json.decode(_response.body);
      }
    }

    @override
    void initState() {
      _getAllUserCurrentlyIssuedBook();
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
              "Currently Issued Book",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: FutureBuilder(
                future: _getAllUserCurrentlyIssuedBook(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List list = snapshot.data;
                            String day = DateFormat('EEEE').format(
                                DateTime.parse(list[index]['due_date']));
                            String date = DateFormat('MM/dd/yyyy').format(
                                DateTime.parse(list[index]['due_date']));
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        userIssuedBookDetails(
                                          accession_no: list[index]
                                              ['accession_no'],
                                          title: list[index]['title'],
                                          issued_date: list[index]
                                              ['issued_date'],
                                          due_date: list[index]['due_date'],
                                          overdue_days: int.parse(list[index]
                                                      ['overdue_days']) <=
                                                  0
                                              ? 0
                                              : int.parse(
                                                  list[index]['overdue_days']),
                                          fines: int.parse(
                                                      list[index]['fines']) <=
                                                  0
                                              ? 0
                                              : int.parse(list[index]['fines']),
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
                                    subtitle: Row(
                                      children: [
                                        Text("Due Date:",
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 14)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        int.parse(list[index]
                                                    ['overdue_days']) <=
                                                0
                                            ? Text(day.toString(),
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 14,
                                                    color:
                                                        Colors.green.shade600,
                                                    fontWeight:
                                                        FontWeight.w600))
                                            : Text(day.toString(),
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 14,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text("-",
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 14,
                                            )),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(date.toString(),
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 14,
                                            )),
                                      ],
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
