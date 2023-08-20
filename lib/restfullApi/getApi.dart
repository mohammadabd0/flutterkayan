import 'dart:convert';
import 'package:flutter_application_task1/model/book.dart';
import 'package:http/http.dart' as http;

Future<List<Book>> fetchData(List<String> query) async {
  const apiKey = "AIzaSyCWswrn9-1ublWXhRtwFAzlWg1be1jMd78";
  final apiUrl =
      "https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey";
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> items = responseData["items"];
      List<Book> bookList = items.map((item) {
        final bookData = item["volumeInfo"];

        String image = bookData["imageLinks"]?["thumbnail"] ?? "";

        String author = bookData.containsKey("authors")
            ? bookData["authors"][0]
            : "Author is not found";

        String publishedDate = bookData.containsKey("publishedDate")
            ? bookData["publishedDate"].toString()
            : DateTime.now().toString();
        DateTime? dateTime;

        if (publishedDate.length == 4 && int.tryParse(publishedDate) != null) {
          int year = int.parse(publishedDate);

          int month = 1;
          int day = 1;

          dateTime = DateTime(year, month, day);
        } else {
          try {
            DateTime parsedDateTime = DateTime.parse(publishedDate);
            dateTime = DateTime(
                parsedDateTime.year, parsedDateTime.month, parsedDateTime.day);
          } catch (e) {
            // ignore: avoid_print
            print("Error parsing date: $e");
          }
        }

        return Book(
          nameBook: bookData["title"] ?? "Unknown Title",
          author: author,
          dateTime: dateTime,
          image: image,
          infolink: bookData["infoLink"] ?? "",
        );
      }).toList();

      return bookList;
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    // ignore: avoid_print
    print("An error occurred: $e");
    throw Exception("Failed to fetch data");
  }
}

//POST

Future<void> sendDataToApi(Book book) async {
  const apiKey = "AIzaSyCWswrn9-1ublWXhRtwFAzlWg1be1jMd78";
  final apiUrl =
      "https://www.googleapis.com/books/v1/mylibrary/bookshelves/shelf/addVolume?key=$apiKey";

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json', // Set content-type as JSON
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode(book.toJson()), // JSON-encoded data
    );

    print("${response.statusCode}");
    if (response.statusCode == 200) {
      print("Data sent successfully!");
    } else {
      print("Failed to send data. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}
