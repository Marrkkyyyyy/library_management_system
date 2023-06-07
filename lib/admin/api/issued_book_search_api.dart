// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/globals.dart' as globals;
import 'package:test/admin/model/issued_book_model.dart';
class fetchCurrentlyIssuedBook {
  var data = [];
  List<issuedBookModel> results = [];

  Future<List<issuedBookModel>> getIssuedBook({String? query}) async {
    String apiUrl = globals.endpoint + "display_currently_issued_book.php";
    var _response = await http
        .post(Uri.parse(apiUrl),headers: {'Accept': 'application/json'});
    if (_response.statusCode == 200) {
      data = json.decode(_response.body);
      results = data.map((e) => issuedBookModel.fromJson(e)).toList();
      if (query != null) {
        results = results
            .where((element) =>
                element.title!.toLowerCase().contains((query.toLowerCase())) ||
                
                element.user_school_id!.toLowerCase().contains((query.toLowerCase())))
            .toList();
      }
    }

    return results;
  }
}
