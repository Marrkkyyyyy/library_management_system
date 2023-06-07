// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/api/book_search_by_category_api.dart';
import 'package:test/admin/list_of_books/add_book.dart';
import 'package:test/admin/list_of_books/book_details.dart';
import 'package:http/http.dart' as http;
import 'package:test/admin/model/book_model.dart';
import 'package:test/globals.dart' as globals;

class listOfBooks extends StatefulWidget {
  final String categoryID;
  final String category;
  listOfBooks({required this.categoryID, required this.category});
  @override
  State<listOfBooks> createState() => _listOfBooksState();
}

class _listOfBooksState extends State<listOfBooks> {
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
              widget.category,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: searchBookByCategory());
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: FutureBuilder(
                future: _getAllBook(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List list = snapshot.data;

                    return list.isEmpty
                        ? Center(
                            child: Text("No Books Found"),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          bookDetails(
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
                                                  ['availability'],
                                              notes: list[index]['notes'])));
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
                            });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    addBook(categoryID: widget.categoryID)));
          },
          backgroundColor: Colors.orange.shade600,
          child: Icon(
            Icons.add,
          )),
    );
  }
}

class searchBookByCategory extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search Book...';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.orange,
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
      String apiUrl =
          globals.endpoint + "list_of_books/search_book_details.php";
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                            child: Text(
                                                list[index]['accession_no'],
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                            child: Text(
                                                list[index]['availability'],
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 16,
                                                    color: list[index][
                                                                'availability'] ==
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
                                    "Notes",
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
                                        child: Container(
                                          height: 54,
                                          child: SingleChildScrollView(
                                              child: Text(list[index]['notes'],
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize: 16))),
                                        )),
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
