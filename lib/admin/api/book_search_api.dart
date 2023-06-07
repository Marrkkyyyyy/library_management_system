// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/globals.dart' as globals;
import 'package:test/admin/model/book_model.dart';

class fetchBookSearch {
  var data = [];
  List<bookModel> results = [];

  Future<List<bookModel>> getBookSearch({String? query}) async {
    String apiUrl = globals.endpoint + "list_of_books/display_book.php";
    var _response = await http
        .post(Uri.parse(apiUrl), headers: {'Accept': 'application/json'});
    if (_response.statusCode == 200) {
      data = json.decode(_response.body);
      results = data.map((e) => bookModel.fromJson(e)).toList();
      if (query != null) {
        results = results
            .where((element) =>
                element.title!.toLowerCase().contains((query.toLowerCase())) ||
                element.accession_no!
                    .toLowerCase()
                    .contains((query.toLowerCase())) ||
                element.author!.toLowerCase().contains((query.toLowerCase())))
            .toList();
      }
    }

    return results;
  }
}
