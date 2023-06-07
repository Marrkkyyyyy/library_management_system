class returnedBookModel {
  String? returned_bookID,
      book_status,
      first_name,
      last_name,
      middle_name,
      title,
      user_school_id,
      accession_no,
      issued_date,
      due_date,
      returned_date,
      overdue_days,
      fines;

  returnedBookModel(
      {required this.returned_bookID,
      required this.book_status,
      required this.first_name,
      required this.last_name,
      required this.middle_name,
      required this.title,
      required this.user_school_id,
      required this.accession_no,
      required this.issued_date,
      required this.due_date,
      required this.returned_date,
      required this.overdue_days,
      required this.fines});
//constructor

  returnedBookModel.fromJson(Map<String, dynamic> json) {
    returned_bookID = json['returned_bookID'];
    book_status = json['book_status'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    middle_name = json['middle_name'];
    title = json['title'];
    user_school_id = json['user_school_id'];
    accession_no = json['accession_no'];
    issued_date = json['issued_date'];
    due_date = json['due_date'];
    returned_date = json['returned_date'];
    overdue_days = json['overdue_days'];
    fines = json['fines'];
  }
}
