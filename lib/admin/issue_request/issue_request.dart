import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/api/issued_book_search_api.dart';
import 'package:test/admin/issue_request/issue_book_request.dart';
import 'package:test/admin/issue_request/issue_request_details.dart';
import 'package:test/admin/model/issued_book_model.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class issueRequest extends StatefulWidget {
  @override
  State<issueRequest> createState() => _issueRequest();
}

class _issueRequest extends State<issueRequest> {
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future _autoDelete() async {
    String apiUrl = globals.endpoint + "issue_request/delete_issue_request.php";
    await http.post(Uri.parse(apiUrl));
  }

  Future _getissueRequest() async {
    String apiUrl =
        globals.endpoint + "issue_request/display_issue_request.php";
    var _response = await http.post(Uri.parse(apiUrl));
    if (_response.statusCode == 200) {
      setStateIfMounted(() {});

      return json.decode(_response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    _autoDelete();
    _getissueRequest();
  }

  String _issueRequestBookID = "";

  void _searchIssueRequestBookID() async {
    String apiUrl =
        globals.endpoint + "issue_request/issue_request_book_id.php";
    var _response = await http.post(Uri.parse(apiUrl), body: {
      "issueRequestBookID": _issueRequestBookID,
    });
    var message = json.decode(_response.body);
    if (message['message'] == "NoDataFound") {
      Fluttertoast.showToast(
          msg: "No Request Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message['message'] == "Accepted") {
      Fluttertoast.showToast(
          msg: "This Request Has Been Accepted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (message['message'] == "Rejected") {
      Fluttertoast.showToast(
          msg: "This Request Has Been Rejected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => issueBookRequest(
                issueRequestID: message['issueRequestID'],
                user_school_id: message['user_school_id'],
                designation: message['designation'],
                degree: message['degree'],
                contact_no: message['contact_no'],
                accession_no: message['accession_no'],
                degreeID: message['degreeID'],
                userID: message['userID'],
                bookID: message['bookID'],
              )));
    }
  }

  Future<void> scanAccessionNoQR() async {
    String AccessionNoQrCodeScan;

    try {
      AccessionNoQrCodeScan = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR)
          .then((value) {
        if (value == "-1") {
          return "";
        } else {
          setState(() {
            _issueRequestBookID = value;
            _searchIssueRequestBookID();
          });
          return _issueRequestBookID = value;
        }
      });
    } on PlatformException {
      AccessionNoQrCodeScan = 'Failed to Scan QR Code.';
    }

    if (!mounted) return;
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
              "Issue Request",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: FutureBuilder(
                future: _getissueRequest(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List list = snapshot.data;
                    return list.isEmpty
                        ? Center(
                            child: Text("No Issue Request Found"),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;
                              return Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  issueRequestDetails(
                                                    user_school_id: list[index]
                                                        ['user_school_id'],
                                                    accession_no: list[index]
                                                        ['accession_no'],
                                                    first_name: list[index]
                                                        ['first_name'],
                                                    last_name: list[index]
                                                        ['last_name'],
                                                    middle_name: list[index]
                                                        ['middle_name'],
                                                    title: list[index]['title'],
                                                    availability: list[index]
                                                        ['availability'],
                                                    status: list[index]
                                                        ['status'],
                                                    date: list[index]['date'],
                                                    contact_no: list[index]
                                                        ['contact_no'],
                                                    designation: list[index]
                                                        ['designation'],
                                                    degree: list[index]
                                                        ['degree'],
                                                  )));
                                    },
                                    child: Card(
                                        elevation: 5,
                                        child: ListTile(
                                          dense: true,
                                          title: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 2.0),
                                            child: Text(list[index]['title'],
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ubuntu(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              Text(
                                                  list[index]['user_school_id'],
                                                  style: GoogleFonts.ubuntu(
                                                    fontSize: 14,
                                                  )),
                                              SizedBox(width: 8),
                                              Text(list[index]['status'],
                                                  style: GoogleFonts.ubuntu(
                                                      fontSize: 14,
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ),
                                          trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 18),
                                        )),
                                  ));
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
          backgroundColor: Colors.orange,
          onPressed: () {
            scanAccessionNoQR();
          },
          child: Icon(Icons.qr_code_scanner_outlined, size: 30)),
    );
  }
}
