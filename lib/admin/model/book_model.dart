class bookModel {
  String? bookID,
      accession_no,
      title,
      author,
      publisher,
      published_year,
      category,
      notes,
      availability;

  bookModel(
      {required this.bookID,
      required this.accession_no,
      required this.title,
      required this.author,
      required this.publisher,
      required this.published_year,
      required this.category,
      required this.notes,
      required this.availability});
//constructor

  bookModel.fromJson(Map<String, dynamic> json) {
    bookID = json['bookID'];
    accession_no = json['accession_no'];
    title = json['title'];
    author = json['author'];
    publisher = json['publisher'];
    published_year = json['published_year'];
    category = json['category'];
    notes = json['notes'];
    availability = json['availability'];
  }
}
