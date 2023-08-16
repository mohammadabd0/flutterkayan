import 'package:flutter/material.dart';
import 'package:flutter_application_task1/bookfolder/addbook.dart';
import 'package:flutter_application_task1/model/book.dart';

// ignore: must_be_immutable
class MyDetailPage extends StatefulWidget {
  late Book book;
  void Function() onDelete;
  MyDetailPage({
    required this.book,
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          "Book Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text(widget.book.getnameBook),
                subtitle: Text(widget.book.getauthor),
                trailing: Text(widget.book.getdateTime.toString()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      _navigateToAddBook(context);
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.onDelete();
                      });
                    },
                    icon: const Icon(Icons.delete_forever_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAddBook(BuildContext context) async {
    Book? editedBook = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBooks(book: widget.book),
      ),
    );

    if (editedBook != null) {
      setState(() {
        widget.book = editedBook;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context, widget.book);
    }
  }

  delete() {
    setState(() {
      widget.onDelete();
    });
  }
}
