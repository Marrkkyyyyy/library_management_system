// // ignore_for_file: file_names, prefer_const_constructors, unnecessary_const, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:test/registration/student_registration.dart';

// class registrationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * .04,
//         vertical: MediaQuery.of(context).size.height * .04,
//       ),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 1,
//               child: Text.rich(TextSpan(
//                   style: GoogleFonts.assistant(
//                       fontSize: 23, fontWeight: FontWeight.w900),
//                   children: const <InlineSpan>[
//                     TextSpan(
//                       text: 'SE',
//                       style: TextStyle(
//                         shadows: const [
//                           Shadow(color: Colors.black, offset: Offset(0, -6))
//                         ],
//                         color: Colors.transparent,
//                         decoration: TextDecoration.underline,
//                         decorationColor: Colors.orange,
//                         decorationThickness: 4,
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'LECT USER TYPE',
//                       style: TextStyle(
//                         shadows: const [
//                           Shadow(color: Colors.black, offset: Offset(0, -6))
//                         ],
//                         color: Colors.transparent,
//                       ),
//                     ),
//                   ])),
//             ),
//             Expanded(
//               flex: 9,
//               child: Center(
//                 child: Column(children: [
//                   InkWell(
//                     onTap: () {},
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: .5,
//                             blurRadius: 3,
//                             offset: Offset(0, 3),
//                           )
//                         ],
//                         color: Colors.white,
//                       ),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * .20,
//                         width: MediaQuery.of(context).size.width * .40,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.admin_panel_settings_rounded,
//                                 size: 60, color: Colors.orange),
//                             SizedBox(height: 5),
//                             Text("Staff",
//                                 style: GoogleFonts.assistant(fontSize: 16)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * .05,
//                   ),
//                   InkWell(
//                     onTap: () {},
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: .5,
//                             blurRadius: 3,
//                             offset: Offset(0, 3),
//                           )
//                         ],
//                         color: Colors.white,
//                       ),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * .20,
//                         width: MediaQuery.of(context).size.width * .40,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             FaIcon(FontAwesomeIcons.userPen,
//                                 size: 45, color: Colors.orange),
//                             SizedBox(height: 8),
//                             Text("Teacher  ",
//                                 style: GoogleFonts.assistant(fontSize: 16)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * .05,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               studentRegistration()));
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: .5,
//                             blurRadius: 3,
//                             offset: Offset(0, 3),
//                           )
//                         ],
//                         color: Colors.white,
//                       ),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * .20,
//                         width: MediaQuery.of(context).size.width * .40,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             FaIcon(FontAwesomeIcons.userGraduate,
//                                 size: 45, color: Colors.orange),
//                             SizedBox(height: 8),
//                             Text("Student",
//                                 style: GoogleFonts.assistant(fontSize: 16)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ]),
//               ),
//             )
//           ]),
//     ));
//   }
// }
