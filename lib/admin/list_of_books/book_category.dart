// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/api/book_search_api.dart';
import 'package:test/admin/list_of_books/list_of_books.dart';
import 'package:http/http.dart' as http;
import 'package:test/admin/model/book_model.dart';
import 'package:test/globals.dart' as globals;

class bookCategory extends StatefulWidget {
  @override
  State<bookCategory> createState() => _bookCategoryState();
}

class _bookCategoryState extends State<bookCategory> {
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

    _addCategory(BuildContext contextD) {
      var category = TextEditingController();
      void _addCategory() async {
        String apiUrl = globals.endpoint + "list_of_books/add_category.php";
        var _response = await http.post(Uri.parse(apiUrl), body: {
          "category": category.text,
        });
        var message = json.decode(_response.body);
        if (message == "Success") {
          Fluttertoast.showToast(
              msg: "Added Category Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context, rootNavigator: true).pop(context);
        } else {
          Fluttertoast.showToast(
              msg: "Error in Adding Category into Database!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }

      AlertDialog alert = AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        actionsPadding: EdgeInsets.only(
          bottom: 5,
          right: 10,
          top: 5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Builder(
          builder: (context) {
            return Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: category,
                  decoration: InputDecoration(label: Text("Category Name"),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      
                      labelStyle: TextStyle(color: Colors.orange)),
                ),
              ],
            ));
          },
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(50, 40),
              padding: EdgeInsets.symmetric(horizontal: 15),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel", style: TextStyle(color: Colors.orange)),
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(50, 40),
              padding: EdgeInsets.symmetric(horizontal: 15),
            ),
            onPressed: () {
              if (category.text == "") {
                Fluttertoast.showToast(
                    msg: "Category Name is Empty!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                _addCategory();
              }
            },
            child: Text("Add", style: TextStyle(color: Colors.orange)),
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

    _editCategory(BuildContext contextD, String categoryID, String category) {
      var edit_category = TextEditingController(text: category);
      void editCategory() async {
        String apiUrl = globals.endpoint + "list_of_books/edit_category.php";
        var _response = await http.post(Uri.parse(apiUrl), body: {
          "categoryID": categoryID,
          "category": edit_category.text,
        });
        var message = json.decode(_response.body);
        if (message == "Success") {
          Fluttertoast.showToast(
              msg: "Successfully Updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context, rootNavigator: true).pop(context);
        } else {
          Fluttertoast.showToast(
              msg: "Error!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }

      AlertDialog alert = AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        actionsPadding: EdgeInsets.only(
          bottom: 5,
          right: 10,
          top: 5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Builder(
          builder: (context) {
            return Container(
                child: TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: edit_category,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  label: Text("Category Name"),
                  labelStyle: TextStyle(color: Colors.orange)),
            ));
          },
        ),
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
            onPressed: () {
              if (edit_category.text == "") {
                Fluttertoast.showToast(
                    msg: "Category Name is Empty!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                editCategory();
              }
            },
            child: Text(
              "Update",
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
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: FutureBuilder(
                future: _getAllCategory(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List list = snapshot.data;
                            return InkWell(
                              onLongPress: () {
                                _editCategory(
                                  context,
                                  list[index]['categoryID'],
                                  list[index]['category'],
                                );
                              },
                              onTap: () {
                                globals.categoryID = list[index]['categoryID'];
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        listOfBooks(
                                            categoryID: list[index]
                                                ['categoryID'],
                                            category: list[index]
                                                ['category'])));
                              },
                              child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    dense: true,
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Text(list[index]['category'],
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addCategory(context);
          },
          backgroundColor: Colors.orange.shade600,
          child: Icon(
            Icons.add,
          )),
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

    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: FutureBuilder(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 12),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 12),
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
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 16)),
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
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 16)),
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
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 16)),
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
                                        child: Text(
                                            list[index]['published_year'],
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 16)),
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
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 16)),
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
                                                child: Text(
                                                    list[index]['notes'],
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
      ),
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
