import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/not_returned_books/not_returned_book_details.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class notReturnedBooks extends StatefulWidget {
  @override
  State<notReturnedBooks> createState() => _notReturnedBooksState();
}

class _notReturnedBooksState extends State<notReturnedBooks> {
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    _getAllNotReturnedBooks() async {
      String apiUrl = globals.endpoint +
          "not_returned_books/display_not_returned_books.php";
      var _response = await http.post(Uri.parse(apiUrl));
      if (_response.statusCode == 200) {
        setStateIfMounted(() {});

        return json.decode(_response.body);
      }
    }

    @override
    void initState() {
      _getAllNotReturnedBooks();
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
              "Not Returned Books",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: FutureBuilder(
                  future: _getAllNotReturnedBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.toList();

                      return data!.isEmpty
                          ? Center(
                              child: Text("No Data Found",
                                  style: GoogleFonts.ubuntu()))
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                List list = snapshot.data;
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                notReturnedBookDetails(
                                                  first_name: list[index]
                                                      ['first_name'],
                                                  last_name: list[index]
                                                      ['last_name'],
                                                  middle_name: list[index]
                                                      ['middle_name'],
                                                  title: list[index]['title'],
                                                  user_school_id: list[index]
                                                      ['user_school_id'],
                                                  accession_no: list[index]
                                                      ['accession_no'],
                                                  contact_no: list[index]
                                                      ['contact_no'],
                                                  designation: list[index]
                                                      ['designation'],
                                                  degree: list[index]['degree'],
                                                  issued_date: list[index]
                                                      ['issued_date'],
                                                  due_date: list[index]
                                                      ['due_date'],
                                                  overdue_days: int.parse(
                                                      list[index]
                                                          ['overdue_days']),
                                                  fines: int.parse(
                                                      list[index]['fines']),
                                                )));
                                  },
                                  child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        dense: true,
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2.0),
                                          child: Text(list[index]['title'],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.assistant(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(list[index]['user_school_id'],
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 14)),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            int.parse(list[index]
                                                        ['overdue_days']) >
                                                    0
                                                ? Row(
                                                    children: [
                                                      Text("Overdue Days:",
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .red)),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                          list[index]
                                                              ['overdue_days'],
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                    ],
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        trailing: Container(
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 18),
                                        ),
                                      )),
                                );
                              });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
