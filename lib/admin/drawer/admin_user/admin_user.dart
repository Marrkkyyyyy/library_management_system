import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

class adminUser extends StatefulWidget {
  @override
  State<adminUser> createState() => _adminUserState();
}

class _adminUserState extends State<adminUser> {
  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    _getAllAdmin() async {
      String apiUrl = globals.endpoint + "display_admin.php";
      var _response = await http.post(Uri.parse(apiUrl));
      if (_response.statusCode == 200) {
        setStateIfMounted(() {});

        return json.decode(_response.body);
      }
    }

    @override
    void initState() {
      _getAllAdmin();
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.orange.shade600,
        automaticallyImplyLeading: false,
        title: Text("Admin User"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: FutureBuilder(
          future: _getAllAdmin(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      return Card(
                          elevation: 5,
                          child: ListTile(
                            dense: true,
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Text(
                                  list[index]['middle_name'] != ""
                                      ? list[index]['last_name'] +
                                          ", " +
                                          list[index]['first_name'] +
                                          " " +
                                          list[index]['middle_name']
                                      : list[index]['last_name'] +
                                          ", " +
                                          list[index]['first_name'],
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ));
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addAdmin(context);
          },
          backgroundColor: Colors.orange.shade600,
          child: Icon(
            Icons.add,
          )),
    );
  }

  _addAdmin(BuildContext contextD) {
    var first_name = TextEditingController();
    var last_name = TextEditingController();
    var middle_name = TextEditingController();
    var email = TextEditingController();
    var password = TextEditingController();
    void addAdmin() async {
      String apiUrl = globals.endpoint + "admin_register.php";
      var _response = await http.post(Uri.parse(apiUrl), body: {
        "first_name": first_name.text,
        "last_name": last_name.text,
        "middle_name":
            middle_name.text == "" ? "" : middle_name.text.toUpperCase() + ".",
        "email": email.text,
        "password": password.text,
      });
      var message = json.decode(_response.body);
      if (message == "Success") {
        Fluttertoast.showToast(
            msg: "Successfully Added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context, rootNavigator: true).pop(context);
        setState(() {
          first_name.text = "";
          last_name.text = "";
          middle_name.text = "";
          email.text = "";
          password.text = "";
        });
      } else if (message == "duplicateID") {
        Fluttertoast.showToast(
            msg:
                "Student ID is already exist. Only unique student ID are allowed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: first_name,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    labelStyle: TextStyle(color: Colors.orange),
                    label: Text("First Name")),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: last_name,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    labelStyle: TextStyle(color: Colors.orange),
                    label: Text("Last Name")),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: middle_name,
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(1),
                ],
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    labelStyle: TextStyle(color: Colors.orange),
                    label: Text("Middle Initial")),
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    labelStyle: TextStyle(color: Colors.orange),
                    label: Text("Email")),
              ),
              TextFormField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    labelStyle: TextStyle(color: Colors.orange),
                    label: Text("Password")),
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
            if (first_name.text == "") {
              Fluttertoast.showToast(
                  msg: "First Name is Empty!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (last_name.text == "") {
              Fluttertoast.showToast(
                  msg: "Last Name is Empty!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (first_name.text.contains(
                    RegExp(r'[0-9!@#$%^&*()_+=\[\]{};:"\\|,.<>\/?]')) ||
                middle_name.text.contains(
                    RegExp(r'[0-9!@#$%^&*()_+=\[\]{};:"\\|,.<>\/?]')) ||
                last_name.text.contains(
                    RegExp(r'[0-9!@#$%^&*()_+=\[\]{};:"\\|,.<>\/?]'))) {
              Fluttertoast.showToast(
                  msg: "Invalid Name",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (email.text == "") {
              Fluttertoast.showToast(
                  msg: "Email is Empty!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (password.text == "") {
              Fluttertoast.showToast(
                  msg: "Password is Empty!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              addAdmin();
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
}
