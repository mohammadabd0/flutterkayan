import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task1/bookfolder/addbook.dart';
import 'package:flutter_application_task1/bookfolder/detail_page.dart';
import 'package:flutter_application_task1/drawerFolder/myLibrary.dart';
import 'package:flutter_application_task1/drawerFolder/myProfile.dart';
import 'package:flutter_application_task1/drawerFolder/settengs.dart';
import 'package:flutter_application_task1/loginService/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/book.dart';
enum SortOption { nameBook, nameAuthor, dateTime }
// ignore: must_be_immutable
class MyBook extends StatefulWidget {
  MyBook({ super.key});

  @override
  State<MyBook> createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
 
  bool isSearchVisible = false;
  late List<Book> booklist = [];
  bool isLoading = true;
  SortOption selectedSortOption = SortOption.dateTime;
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
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

  @override
  Widget build(BuildContext context) {

    return isLoading ? loadingPage() : buildList();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        "Book shope",
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        PopupMenuButton<SortOption>(
          icon: const Icon(Icons.sort, color: Colors.white),
          onSelected: (value) {
            setState(() {
              selectedSortOption = value;
              sortBooks();
            });
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: SortOption.nameBook,
              child: Text('Sort by Name Book'), 
            ),
            const PopupMenuItem(
              value: SortOption.nameAuthor,
              child: Text('Sort by Name Author'),
            ),
            const PopupMenuItem(
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
        drawer: Drawer(
          shadowColor: Colors.white,
          width: 300,
          backgroundColor: Colors.white,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('My Profile '),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfilePage(
                                email: "",
                                username:"",
                              )),
                    );
                  },
                ),
                ListTile(
                  title: const Text('My Library'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyLibraryPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MySettingsPage(),
                      ),
                    );
                  },
                ),
                const Divider(height: 10),
                ListTile(
                  title: const Text('Logout'),
                  onTap: ()async {
                   await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: booklist.length,
            itemBuilder: (context, index) {
              Book book = booklist[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _navigateToDetailPage(index);
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Add padding around the row widget
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  book.getimage,
                                  height: 130,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                                Container(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(height: 5),
                                      Text(
                                        book.getnameBook,
                                      ),
                                      Container(height: 5),
                                      Text(
                                        book.getauthor,
                                      ),
                                      Container(height: 10),
                                      Text(
                                        book.getdateTime.toString(),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            Book newbook = Book(
                author: " ",
                dateTime: DateTime.now(),
                nameBook: " ",
                image: " ");
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
        title: const Text("Book List"),
      ),
      body: const Center(
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
          booklist.sort((a, b) => a.getdateTime!.compareTo(b.getdateTime!));
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

                      saveBook();
                      Navigator.pop(context);
                      Navigator.pop(context);
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
            book: booklist[index], onDelete: () => deleteBook(index)),
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
