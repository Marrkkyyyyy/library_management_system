// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class notReturnedBookDetails extends StatefulWidget {
  final String first_name;
  final String last_name;
  final String middle_name;
  final String title;
  final String user_school_id;
  final String accession_no;
  final String contact_no;
  final String designation;
  final String degree;
  final String issued_date;
  final String due_date;
  final int overdue_days;
  final int fines;

  notReturnedBookDetails({
    required this.first_name,
    required this.last_name,
    required this.middle_name,
    required this.title,
    required this.user_school_id,
    required this.accession_no,
    required this.contact_no,
    required this.designation,
    required this.degree,
    required this.issued_date,
    required this.due_date,
    required this.overdue_days,
    required this.fines,
  });

  @override
  State<notReturnedBookDetails> createState() => _notReturnedBookDetailsState();
}

class _notReturnedBookDetailsState extends State<notReturnedBookDetails> {
  TextStyle textFieldTitle = GoogleFonts.alegreyaSans(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade600,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              "Not Returned Book Details",
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
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(
                                width: 20,
                              ),
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
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contact No.",
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
                                    child: Text(widget.contact_no,
                                        style:
                                            GoogleFonts.ubuntu(fontSize: 16)),
                                  ),
                                ),
                              ],
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
                                        "Designation",
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
                                          child: Text(widget.designation,
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
                                        widget.designation == "Senior High"
                                            ? "Strand"
                                            : widget.designation == "College"
                                                ? "Course"
                                                : "Department",
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
                                          child: Text(widget.degree,
                                              style: GoogleFonts.ubuntu(
                                                  height: 1.3, fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
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
                                        "Issued Date",
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
                                          child: Text(widget.issued_date,
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Due Date",
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
                                            child: Text(widget.due_date,
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: 16))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
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
                                        "Overdue Days",
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
                                          child: Text(
                                              widget.overdue_days <= 0
                                                  ? "0"
                                                  : widget.overdue_days
                                                      .toString(),
                                              style: GoogleFonts.ubuntu(
                                                  color: widget.overdue_days > 0
                                                      ? Colors.red
                                                      : Colors.black,
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
                                        "Fines",
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
                                          child: Text(
                                              widget.fines <= 0
                                                  ? "0"
                                                  : widget.fines.toString(),
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
