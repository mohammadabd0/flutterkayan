import 'package:flutter/material.dart';
import 'package:flutter_application_task1/model/book.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_application_task1/restfullApi/getApi.dart';

class AddBooks extends StatefulWidget {
  final Book? book;
  const AddBooks({required this.book, Key? key}) : super(key: key);

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late Book newbook;
  List<String> categories = [
    'information technology',
    'business analytics',
    'kids books',
    'drawing',
    'english',
    'Law',
    'cartoon',
    'AI',
    'Kids',
    'Sleep',
  ];
  List<Book> dataListBook = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  void initState() {
    newbook = widget.book ??
        Book(nameBook: "", author: "", dateTime: DateTime.now(), image: "");
    _nameController.text = newbook.getnameBook;
    _authorController.text = newbook.getauthor;
    super.initState();
  }

  int _selectedIndex = -1;
  @override
  void dispose() {
    _nameController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Update Page",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black87,
                      ),
                      child: TextButton(
                        onPressed: () {
                          fetchData([category]).then((dataList) {
                            setState(() {
                              dataListBook = dataList;
                            });
                          });
                        },
                        child: Text(
                          category,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dataListBook.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        newbook.setimage = dataListBook[index].getimage;
                        _selectedIndex = index;
                      });
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 8),
                          child: Image.network(
                            dataListBook[index].getimage,
                            height: 130,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        if (_selectedIndex == index)
                          Container(
                            color: Colors.white,
                            child: const Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 10, left: 16),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: "name",
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "set a name",
                        hintText: "set a name",
                        prefixIcon: Icon(Icons.book),
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == newbook.getnameBook) {
                          return "Please enter name";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        newbook.setnameBook = newValue!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FormBuilderTextField(
                      name: "author",
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: "set author",
                        hintText: "set author",
                        prefixIcon: Icon(Icons.face),
                      ),
                      controller: _authorController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == newbook.getauthor) {
                          return 'Please enter author';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        newbook.setauthor = newValue!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FormBuilderDateTimePicker(
                      initialValue: newbook.getdateTime,
                      name: 'date_field',
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        labelText: 'Select a date',
                        prefixIcon: Icon(Icons.date_range),
                      ),
                      validator: (value) {
                        // ignore: unrelated_type_equality_checks
                        if (value == '' || value == newbook.getdateTime) {
                          return 'Please enter date';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        newbook.setdateTime = newValue!;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_selectedIndex < 0) {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('You must select one of the image'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.pop(context, newbook);
          }
        },
        tooltip: 'Save',
        child: const Text('Save'),
      ),
    );
  }
}
