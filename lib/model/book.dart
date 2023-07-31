class Book {
  String? _nameBook;
  String? _author;
  DateTime? _dateTime;

  Book({String author = "", String nameBook = "", DateTime? dateTime}) {
    _author = author;
    _nameBook = nameBook;
    _dateTime = dateTime!;
  }

  String get getnameBook {
    return _nameBook!;
  }

  set setnameBook(String newName) {
    _nameBook = newName;
  }

  String get getauthor {
    return _author!;
  }

  set setauthor(String newAuthor) {
    _author = newAuthor;
  }

  DateTime get getdateTime {
    return _dateTime!;
  }

  set setdateTime(DateTime newDateTime) {
    _dateTime = newDateTime;
  }

  Map<String, dynamic> toJson() {
    return {
      "bookName": _nameBook,
      "author": _author,
      "dateTime": _dateTime?.toIso8601String(),
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      nameBook: json["bookName"],
      author: json["author"],
      dateTime: DateTime.parse(json["dateTime"]),
    );
  }
}
