class Book {
  String? _nameBook;
  String? _author;
  DateTime? _dateTime;
  String? _image;

  Book(
      {String author = "",
      String nameBook = "",
      DateTime? dateTime,
      String image = ""}) {
    _author = author;
    _nameBook = nameBook;
    _dateTime = dateTime!;
    _image = image;
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

  String get getimage {
    return _image!;
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
      "image":_image
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      nameBook: json["bookName"],
      author: json["author"],
      dateTime: DateTime.parse(json["dateTime"]),
      image: json["image"],
    );
  }
}
