import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/admin/drawer/admin_user/admin_user.dart';
import 'package:test/intro_page.dart';
import 'package:test/login.dart';

class adminDrawer extends StatefulWidget {
  final String adminID;
  final String first_name;
  final String last_name;
  final String middle_name;
  final String email;
  final String password;

  adminDrawer(
      {required this.adminID,
      required this.first_name,
      required this.last_name,
      required this.middle_name,
      required this.email,
      required this.password});
  @override
  State<adminDrawer> createState() => _adminDrawerState();
}

class _adminDrawerState extends State<adminDrawer> {
  alertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      titlePadding: EdgeInsets.fromLTRB(25, 30, 25, 0),
      contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 10),
      title: Text("Are you sure?",
          style: GoogleFonts.assistant(
            fontWeight: FontWeight.bold,
          )),
      content: Text("Do you want to logout?",
          style: GoogleFonts.assistant(
            fontSize: 17,
            height: 1.5,
            letterSpacing: 1.3,
          )),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(80, 40),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(80, 40),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Login()));
          },
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.orange.shade600),
              accountName: Text(
                widget.middle_name == ""
                    ? (widget.first_name + " " + widget.last_name)
                    : (widget.first_name +
                        " " +
                        widget.middle_name +
                        " " +
                        widget.last_name),
                style: GoogleFonts.assistant(
                    fontSize: 21, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(widget.email,
                  style: GoogleFonts.assistant(fontSize: 16),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_rounded),
            title: Text("User Admin"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => adminUser()));
            },
          ),
          ListTile(
            leading: Icon(Icons.format_list_bulleted_rounded),
            title: Text("Reports"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              alertDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
