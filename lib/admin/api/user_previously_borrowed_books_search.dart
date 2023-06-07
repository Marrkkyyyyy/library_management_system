// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/globals.dart' as globals;
import 'package:test/admin/model/returned_book_model.dart';

class fetchPreviouslyBorrowedBook {
  var data = [];
  List<returnedBookModel> results = [];

  Future<List<returnedBookModel>> getPreviouslyBorrowedBook(
      {String? query, userID}) async {
    String apiUrl =
        globals.endpoint + "user_display_previously_borrowed_books.php";
    var _response = await http.post(Uri.parse(apiUrl),
        body: {"userID": userID}, headers: {'Accept': 'application/json'});
    if (_response.statusCode == 200) {
      data = json.decode(_response.body);
      results = data.map((e) => returnedBookModel.fromJson(e)).toList();
      if (query != null) {
        results = results
            .where((element) =>
                element.title!.toLowerCase().contains((query.toLowerCase())))
            .toList();
      }
    }

    return results;
  }
}
