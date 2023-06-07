// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/api/book_search_api.dart';
import 'package:test/admin/model/book_model.dart';
import 'package:test/user/list_of_books/user_issue_request_details.dart';
import 'package:test/user/list_of_books/list_of_books.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bottom_drawer/bottom_drawer.dart';

class userBookCategory extends StatefulWidget {
  @override
  State<userBookCategory> createState() => _userBookCategoryState();
}

class _userBookCategoryState extends State<userBookCategory> {
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    _getAllCategory() async {
      String apiUrl = globals.endpoint + "list_of_books/display_category.php";
      var _response = await http.post(Uri.parse(apiUrl));
      if (_response.statusCode == 200) {
        setStateIfMounted(() {});

        return json.decode(_response.body);
      }
    }

    @override
    void initState() {
      _getAllCategory();
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
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
          "Category",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: searchBook());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 5, left: 5, top: 15, bottom: 70),
            child: FutureBuilder(
              future: _getAllCategory(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          return InkWell(
                            onTap: () {
                              globals.categoryID = list[index]['categoryID'];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      userListOfBooks(
                                          categoryID: list[index]['categoryID'],
                                          category: list[index]['category'])));
                            },
                            child: Card(
                                elevation: 5,
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  dense: true,
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Text(list[index]['category'],
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  trailing: Container(
                                    child: Icon(Icons.arrow_forward_ios_rounded,
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
          userIssueRequest(context),
        ],
      ),
    );
  }

  BottomDrawerController _controller = BottomDrawerController();

  Widget userIssueRequest(BuildContext context) {
    _getUserIssueRequest() async {
      String apiUrl = globals.endpoint +
          "user_issue_request/display_user_issue_request.php";
      var _response =
          await http.post(Uri.parse(apiUrl), body: {'userID': globals.userID});
      if (_response.statusCode == 200) {
        setStateIfMounted(() {});

        return json.decode(_response.body);
      }
    }

    @override
    void initState() {
      _getUserIssueRequest();
      super.initState();
    }

    return BottomDrawer(
      cornerRadius: 20,
      header: Container(
          decoration: BoxDecoration(
              color: Colors.teal.shade600,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          width: MediaQuery.of(context).size.width * 1,
          height: 60,
          child: Stack(
            children: [
              Center(
                  child: Text("Issue Requests",
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white))),
            ],
          )),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        child: FutureBuilder(
          future: _getUserIssueRequest(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List list = snapshot.data;

              return list.isEmpty
                  ? Center(
                      child: Text("No Request Found"),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        return Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      userIssueRequestDetails(
                                        issueRequestID: list[index]
                                            ['issueRequestID'],
                                        accession_no: list[index]
                                            ['accession_no'],
                                        title: list[index]['title'],
                                        author: list[index]['author'],
                                        publisher: list[index]['publisher'],
                                        published_year: list[index]
                                            ['published_year'],
                                        category: list[index]['category'],
                                        status: list[index]['status'],
                                        availability: list[index]
                                            ['availability'],
                                             designation: list[index]
                                            ['designation'],
                                             degree: list[index]
                                            ['degree'],
                                             contact_no: list[index]
                                            ['contact_no'],
                                      )));
                            },
                            child: Card(
                                shadowColor: Colors.teal.shade600,
                                elevation: 5,
                                child: ListTile(
                                  dense: true,
                                  title: Container(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Text(list[index]['title'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(list[index]['accession_no'],
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 14,
                                          )),
                                      SizedBox(width: 8),
                                      Text(list[index]['status'],
                                          style: GoogleFonts.ubuntu(
                                              fontSize: 14,
                                              color: list[index]['status'] ==
                                                      'Accepted'
                                                  ? Colors.green
                                                  : list[index]['status'] ==
                                                          'Rejected'
                                                      ? Colors.red
                                                      : Colors.orange,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18),
                                )),
                          ),
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
      headerHeight: 60,
      drawerHeight: 400.0,
      color: Colors.white,
      controller: _controller,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 5,
          offset: const Offset(2, -6), // changes position of shadow
        ),
      ],
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
                                    "Quantity",
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
                                      child: Text(list[index]['quantity'],
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

  fetchBookSearch _fetchBook = fetchBookSearch();
  @override
  Widget buildSuggestions(BuildContext context) =>
      FutureBuilder<List<bookModel>>(
          future: _fetchBook.getBookSearch(query: query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data?.toList();
              return data!.isEmpty
                  ? Center(
                      child: Text("No Data Found",
                          style: GoogleFonts.ubuntu()))
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
