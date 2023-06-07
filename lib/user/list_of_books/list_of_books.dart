// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/api/book_search_by_category_api.dart';
import 'package:test/admin/model/book_model.dart';
import 'package:test/user/list_of_books/book_details.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class userListOfBooks extends StatefulWidget {
  final String categoryID;
  final String category;
  userListOfBooks({required this.categoryID, required this.category});

  @override
  State<userListOfBooks> createState() => _userListOfBooksState();
}

class _userListOfBooksState extends State<userListOfBooks> {
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future _getAllBook() async {
    String apiUrl =
        globals.endpoint + "list_of_books/display_book_by_category.php";
    var _response = await http
        .post(Uri.parse(apiUrl), body: {'categoryID': widget.categoryID});
    if (_response.statusCode == 200) {
      setStateIfMounted(() {});

      return json.decode(_response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade600,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: searchBook());
                  },
                  icon: Icon(Icons.search))
            ],
            expandedHeight: MediaQuery.of(context).size.height * 0.18,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.5,
              titlePadding: EdgeInsetsDirectional.only(
                start: 50.0,
                bottom: 17.0,
              ),
              title: RichText(
                  text: TextSpan(text: '', children: [
                TextSpan(
                    text: 'List of Books',
                    style: GoogleFonts.bioRhyme(
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800)),
                TextSpan(text: '\n'),
                TextSpan(
                    text: widget.category,
                    style: GoogleFonts.assistant(
                      fontSize: 12,
                    ))
              ])),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              height: MediaQuery.of(context).size.height * .90,
              width: MediaQuery.of(context).size.width * 1,
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                ),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(55, 0, 20, 20),
                child: FutureBuilder(
                  future: _getAllBook(),
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
                                          userBookDetails(
                                              bookID: list[index]['bookID'],
                                              accession_no: list[index]
                                                  ['accession_no'],
                                              title: list[index]['title'],
                                              author: list[index]['author'],
                                              publisher: list[index]
                                                  ['publisher'],
                                              published_year: list[index]
                                                  ['published_year'],
                                              category: list[index]['category'],
                                              availability: list[index]
                                                  ['availability'])));
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
                                      subtitle: list[index]['availability'] !=
                                              'Not Available'
                                          ? Text("Available",
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 15,
                                                  color: Colors.green))
                                          : Text("Not Available",
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 15,
                                                  color: Colors.red)),
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
            ),
          )
        ],
      ),
    );
  }
}

class searchBook extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search Book...';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.teal,
        ),
        textTheme: const TextTheme(
            headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        )),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
        ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future _getBookSearchDetails() async {
      String apiUrl = globals.endpoint + "search_book_details.php";
      var _response =
          await http.post(Uri.parse(apiUrl), body: {'search': query});
      return json.decode(_response.body);
    }

    return FutureBuilder(
      future: _getBookSearchDetails(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  List list = snapshot.data;
                  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  );
                  return Container(
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
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: Text(list[index]['accession_no'],
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
                                    "Title",
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
                                      child: Text(list[index]['title'],
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
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      child: Text(list[index]['author'],
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
                                      child: Text(list[index]['publisher'],
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
                                      child: Text(list[index]['published_year'],
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
                                      child: Text(list[index]['category'],
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
                                    "Availability",
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
                                      child: Text(list[index]['availability'],
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 16,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  fetchBookSearchByCategory _fetchBook = fetchBookSearchByCategory();
  @override
  Widget buildSuggestions(BuildContext context) =>
      FutureBuilder<List<bookModel>>(
          future: _fetchBook.getBookSearchByCategory(query: query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data?.toList();
              return data!.isEmpty
                  ? Center(
                      child: Text("No Data Found", style: GoogleFonts.ubuntu()))
                  : ListView.builder(
                      reverse: false,
                      shrinkWrap: false,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var title = data[index].title;

                        return InkWell(
                          onTap: () {
                            query = title.toString();

                            showResults(context);
                          },
                          child: ListTile(
                            minLeadingWidth: 0,
                            dense: true,
                            leading: Icon(Icons.menu_book_rounded,
                                color: Colors.teal.shade600),
                            title: Text(title.toString(),
                                style: TextStyle(fontSize: 14)),
                          ),
                        );
                      },
                    );
            } else
              return Center(child: CircularProgressIndicator());
          });
}
