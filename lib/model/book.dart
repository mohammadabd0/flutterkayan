class Book {
  String? _nameBook;
  String? _author;
  DateTime? _dateTime;
  String? _image;
  String? _infolink;
  Book( {String author = "",String nameBook = "",DateTime? dateTime,String image = "",String infolink = ""}) {
    _author = author;
    _nameBook = nameBook;
    _dateTime = dateTime;
    _image = image;
    _infolink =infolink;
  }

  set setinfolink(String newinfolink) {
    _infolink = newinfolink;
  }


 String get getinfolink {
    return _infolink!;
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

  DateTime? get getdateTime {
    return _dateTime;
  }

  set setdateTime(DateTime? newDateTime) {
    _dateTime = newDateTime;
  }

  Map<String, dynamic> toJson() {
    return {
      "bookName": _nameBook,
      "author": _author,
      "dateTime": _dateTime?.toIso8601String(),
      "image":_image,
      "infolink":_infolink

    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      nameBook: json["bookName"],
      author: json["author"],
      dateTime: DateTime.parse(json["dateTime"]),
      image: json["image"],
      infolink: json["infolink"]
    );
  }
}
