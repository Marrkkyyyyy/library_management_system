import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class userConfirmationIssueRequestBook extends StatefulWidget {
  final String bookID;

  userConfirmationIssueRequestBook({
    required this.bookID,
  });
  @override
  State<userConfirmationIssueRequestBook> createState() =>
      _userConfirmationIssueRequestBookState();
}

class _userConfirmationIssueRequestBookState
    extends State<userConfirmationIssueRequestBook> {
  String? _designation_value;
  String? _strand_value;
  String _temp_strand_value = "";
  String? _string_strand_value;

  String? _course_value;
  String _temp_course_value = "";
  String? _string_course_value;

  String? _department_value;
  String _temp_department_value = "";
  String? _string_department_value;

  final _designation_list = [
    'Senior High',
    'College',
    'Faculty',
  ];

  List _strand_list = [];
  List _course_list = [];
  List _department_list = [];
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future getStrand() async {
    String apiUrl = globals.endpoint + 'issue_book/display_degree.php';
    var _response =
        await http.post(Uri.parse(apiUrl), body: {'designation': "1"});
    var jsonData = jsonDecode(_response.body);
    if (_response.statusCode == 200) {
      setStateIfMounted(() {
        _strand_list = jsonData;
      });

      return json.decode(_response.body);
    }
  }

  Future getCourse() async {
    String apiUrl = globals.endpoint + 'issue_book/display_degree.php';
    var _response =
        await http.post(Uri.parse(apiUrl), body: {'designation': "2"});
    var jsonData = jsonDecode(_response.body);
    if (_response.statusCode == 200) {
      setStateIfMounted(() {
        _course_list = jsonData;
      });

      return json.decode(_response.body);
    }
  }

  Future getDepartment() async {
    String apiUrl = globals.endpoint + 'issue_book/display_degree.php';
    var _response =
        await http.post(Uri.parse(apiUrl), body: {'designation': "3"});
    var jsonData = jsonDecode(_response.body);
    if (_response.statusCode == 200) {
      setStateIfMounted(() {
        _department_list = jsonData;
      });

      return json.decode(_response.body);
    }
  }

  DropdownMenuItem<String> _designation(String block) {
    return DropdownMenuItem(value: block, child: Text(block));
  }

  var contact_no = TextEditingController();
  var department = TextEditingController();
  var course = TextEditingController();
  var strand = TextEditingController();

  @override
  void initState() {
    getDepartment();
    getStrand();
    getCourse();
    super.initState();
  }

  void issueConfirmationRequest() async {
    String apiUrl = globals.endpoint + "user_issue_request/issue_request.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "userID": globals.userID,
      "bookID": widget.bookID,
      "contact_no": contact_no.text,
      "designation": _designation_value.toString(),
      "degree": _designation_value.toString() == "Senior High"
          ? _strand_value.toString()
          : _designation_value.toString() == "College"
              ? _course_value.toString()
              : _department_value.toString()
    });
    var message = json.decode(_response.body);
    if (message == "Success") {
      Fluttertoast.showToast(
          msg: "Request Sent to Admin",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context, rootNavigator: true).pop(context);
    } else if (message == "duplicateIssueRequest") {
      Fluttertoast.showToast(
          msg: "Request Already Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message == "Max") {
      Fluttertoast.showToast(
          msg: "You Reached the Limit of Book to Request",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error in Requesting Book into Database!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 1,
        height: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Number",
                    style: GoogleFonts.ubuntu(fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: .5,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      )
                    ]),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: contact_no,
                        autocorrect: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
                            isDense: true,
                            hintText: 'Enter Contact Number',
                            hintStyle:
                                TextStyle(fontSize: 14.0, color: Colors.grey),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.5)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1.5)))),
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
                        "Designation",
                        style: GoogleFonts.ubuntu(fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: .5,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        ]),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              isDense: true,
                              hintText: 'Enter Designation',
                              hintStyle:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.5)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.5)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.5))),
                          items: _designation_list.map(_designation).toList(),
                          onChanged: (value) {
                            setState(() {
                              _designation_value = value;
                            });
                          },
                        ),
                      )
                    ])),
            _designation_value.toString() == "Senior High"
                ? Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          "Strand",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: .5,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            )
                          ]),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 15),
                                isDense: true,
                                hintText: 'Enter Strand',
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 1.5)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 1.5)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 1.5))),
                            items: _strand_list.map((item) {
                              _strand_value = _temp_strand_value == ""
                                  ? _strand_list[0]['degree']
                                  : _string_strand_value;
                              return DropdownMenuItem(
                                child: new Text(item['degree']),
                                value: item['degree'].toString(),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _string_strand_value = value!;
                                _temp_strand_value = value;
                              });
                            },
                            value: _strand_value,
                          ),
                        )
                      ]))
                : _designation_value.toString() == "College"
                    ? Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              "Course",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: .5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                )
                              ]),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 15),
                                    isDense: true,
                                    hintText: 'Enter Course',
                                    hintStyle: TextStyle(
                                        fontSize: 14.0, color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1.5)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1.5)),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1.5))),
                                items: _course_list.map((item) {
                                  _course_value = _temp_course_value == ""
                                      ? _course_list[0]['degree']
                                      : _string_course_value;
                                  return DropdownMenuItem(
                                    child: new Text(item['degree']),
                                    value: item['degree'].toString(),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _string_course_value = value!;
                                    _temp_course_value = value;
                                  });
                                },
                                value: _course_value,
                              ),
                            )
                          ]))
                    : _designation_value == "Faculty"
                        ? Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(
                                  "Department",
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: .5,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 15),
                                        isDense: true,
                                        hintText: 'Enter Department',
                                        hintStyle: TextStyle(
                                            fontSize: 14.0, color: Colors.grey),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                width: 1.5)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                width: 1.5)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                width: 1.5))),
                                    items: _department_list.map((item) {
                                      _department_value =
                                          _temp_department_value == ""
                                              ? _department_list[0]['degree']
                                              : _string_department_value;
                                      return DropdownMenuItem(
                                        child: new Text(item['degree']),
                                        value: item['degree'].toString(),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _string_department_value = value!;
                                        _temp_department_value = value;
                                      });
                                    },
                                    value: _department_value,
                                  ),
                                )
                              ]))
                        : Container(),
            Container(
              padding: EdgeInsets.only(
                  top: _designation_value == "Senior High"
                      ? 19
                      : _designation_value == "College"
                          ? 19
                          : _designation_value == "Faculty"
                              ? 19
                              : 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(80, 40),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(80, 40),
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      if (contact_no.text == "") {
                        Fluttertoast.showToast(
                            msg: "Contact Number Cannot Be Null",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (contact_no.text.length != 11) {
                        Fluttertoast.showToast(
                            msg: "Invalid Number",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (contact_no.text.substring(0, 2) != "09") {
                        Fluttertoast.showToast(
                            msg: "Invalid Number",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (this._designation_value == null) {
                        Fluttertoast.showToast(
                            msg: "Designation Cannot Be Null",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        issueConfirmationRequest();
                      }
                    },
                    child: Text(
                      "Request",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
