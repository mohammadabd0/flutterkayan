import 'dart:async';
import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_task1/addbook.dart';
import 'package:flutter_application_task1/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/book.dart';

enum SortOption { nameBook, nameAuthor, dateTime }

class MyBook extends StatefulWidget {
  MyBook({super.key});

  @override
  State<MyBook> createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  final List<String> bookImages = [
    'assets/images/icon-book.png',
    'assets/images/PNG2105.png',
    'assets/images/pngimg.png',
  ];
  bool isSearchVisible = false;

  //List<Book> filteredBookList = [];

  late List<Book> booklist = [
   
  ];
  bool isLoading = true;
  SortOption selectedSortOption = SortOption.dateTime;

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        booklist;
        isLoading = false;
      });
    });

      loadbook(); // Load the saved books
    super.initState();

  }

  void loadbook() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonbook = preferences.getString("book") ?? '[]';
    List<dynamic> bookData = jsonDecode(jsonbook);
    List<Book> books = bookData.map((e) => Book.fromJson(e)).toList();
    setState(() {
      booklist = books;
      isLoading = false;
    });
  }

  void saveBook() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonbook = jsonEncode(booklist);
    preferences.setString("book", jsonbook);
  }
/*
  void updateList(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredBookList = booklist;
      } else {
        filteredBookList = booklist
            .where((element) =>
                element.getnameBook.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return isLoading ? loadingPage() : buildList();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(
        "Book List",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        /*Padding(
          padding: const EdgeInsets.all(5),
          child: isSearchVisible
              ? Container(
                  width: 200,
                  height: 40,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: false,
                      fillColor: Colors.white,
                      hintText: 'Search Books',
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                    onChanged: (value) => updateList(value),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearchVisible = true;
                    });
                  },
                ),
        ),*/
        PopupMenuButton<SortOption>(
          icon: Icon(Icons.sort, color: Colors.white),
          onSelected: (value) {
            setState(() {
              selectedSortOption = value;
              sortBooks();
            });
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: SortOption.nameBook,
              child: Text('Sort by Name Book'),
            ),
            PopupMenuItem(
              value: SortOption.nameAuthor,
              child: Text('Sort by Name Author'),
            ),
            PopupMenuItem(
              value: SortOption.dateTime,
              child: Text('Sort by Date Time'),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildList() {
    return GestureDetector(
      onTap: () {
        if (isSearchVisible) {
          setState(() {
            isSearchVisible = false;
          });
        }
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: booklist.length,
            itemBuilder: (context, index) {
              Book book = booklist[index];
              var randomIndex = Random().nextInt(bookImages.length);
              return 
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _navigateToDetailPage(index);
                    },
                    child: Card(
                      elevation: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            bookImages[randomIndex],
                            width: 80,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListTile(
                                title: Text(book.getnameBook),
                                subtitle: Text(book.getauthor),
                                trailing: Text(book.getdateTime.toString()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          onPressed: () async {
            Book newbook =
                Book(author: "", dateTime: DateTime.now(), nameBook: "");
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBooks(book: newbook),
                settings: RouteSettings(
                  arguments: newbook,
                ),
              ),
            );

            if (result != null) {
              setState(() {
                booklist.add(result as Book);
              });
              saveBook();
            }
          },
        ),
      ),
    );
  }

  Widget loadingPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Book List"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void sortBooks() {
    setState(() {
      switch (selectedSortOption) {
        case SortOption.nameBook:
          booklist.sort((a, b) => a.getnameBook.compareTo(b.getnameBook));
          break;
        case SortOption.nameAuthor:
          booklist.sort((a, b) => a.getauthor.compareTo(b.getauthor));
          break;
        case SortOption.dateTime:
          booklist.sort((a, b) => a.getdateTime.compareTo(b.getdateTime));
          break;
      }
    });
  }

   void deleteBook(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Are you sure you want to delete this book?"),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      booklist.removeAt(index);
                    });
                    saveBook(); // Save the updated book list after deletion
                  },
                  child: const Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
  void _navigateToDetailPage(int index) async {
    Book? editedBook = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDetailPage(
          book: booklist[index],
          onDelete: () => deleteBook(index)
        
        ),
      ),
    );

    if (editedBook != null) {
      setState(() {
        booklist[index] = editedBook;
      });
      saveBook();
    }
  }
}
