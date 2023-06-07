// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class issueRequestDetails extends StatefulWidget {
  final String first_name;
  final String last_name;
  final String middle_name;
  final String title;
  final String user_school_id;
  final String accession_no;
  final String contact_no;
  final String designation;
  final String date;
  final String status;
  final String availability;
  final String degree;

  issueRequestDetails({
    required this.first_name,
    required this.last_name,
    required this.middle_name,
    required this.title,
    required this.user_school_id,
    required this.accession_no,
    required this.contact_no,
    required this.designation,
    required this.date,
    required this.status,
    required this.availability,
    required this.degree,
  });
  @override
  State<issueRequestDetails> createState() => _issueRequestDetailsState();
}

class _issueRequestDetailsState extends State<issueRequestDetails> {
  bool isExpanded = false;
  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    // String issued =
    //     DateFormat('MM/dd/yyyy').format(DateTime.parse(widget.issued_date));
    // String due =
    //     DateFormat('MM/dd/yyyy').format(DateTime.parse(widget.due_date));
    return Scaffold(
      backgroundColor: Colors.orange.shade600,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              "Issue Request Details",
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                    height: MediaQuery.of(context).size.height * .90,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
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
                            padding: EdgeInsets.only(bottom: 20, top: 20),
                            child: ExpansionPanelList(
                              animationDuration: Duration(milliseconds: 500),
                              dividerColor: Colors.red,
                              expandedHeaderPadding:
                                  EdgeInsets.only(bottom: 0.0),
                              elevation: 1,
                              children: [
                                ExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Borrower's Information",
                                                style: GoogleFonts.ubuntu(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                )),
                                          ]),
                                    );
                                  },
                                  body: Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              bottom: 20, top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Contact No.",
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 12),
                                                  child: Text(widget.contact_no,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Designation",
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 12),
                                                  child: Text(
                                                      widget.designation,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Degree",
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 12),
                                                  child: Text(widget.degree,
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 16)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isExpanded: isExpanded,
                                )
                              ],
                              expansionCallback: (int item, bool status) {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "User ID",
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
                                          child: Text(widget.user_school_id,
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
                                flex: 6,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Accession No.",
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: .5,
                                              blurRadius: 3,
                                              offset: Offset(0, 3),
                                            )
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
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
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
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
                                    child: Text(
                                        widget.last_name +
                                            ", " +
                                            widget.first_name +
                                            " " +
                                            widget.middle_name,
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
                                  "Book Title",
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
                            padding: EdgeInsets.only(bottom: 75),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
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
                                    child: Text(widget.status,
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 16,
                                          color: Colors.orange,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () {},
        label: Text("Reject"),
        icon: Icon(Icons.close),
      ),
    );
  }
}
