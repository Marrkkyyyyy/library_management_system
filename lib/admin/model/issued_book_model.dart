class issuedBookModel {
  String? issue_bookID,
      title,
      accession_no,
      first_name,
      last_name,
      middle_name,
      contact_no,
      designation,
      user_school_id,
      issued_date,
      due_date;

  issuedBookModel(
      {required this.issue_bookID,
      required this.title,
      required this.accession_no,
      required this.first_name,
      required this.last_name,
      required this.middle_name,
      required this.contact_no,
      required this.designation,
      required this.user_school_id,
      required this.issued_date,
      required this.due_date});
//constructor

  issuedBookModel.fromJson(Map<String, dynamic> json) {
    issue_bookID = json['issue_bookID'];
    title = json['title'];
    accession_no = json['accession_no'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    middle_name = json['middle_name'];
    contact_no = json['contact_no'];
    designation = json['designation'];
    user_school_id = json['user_school_id'];
    issued_date = json['issued_date'];
    due_date = json['due_date'];
  }
}
