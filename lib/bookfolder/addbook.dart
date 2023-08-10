import 'package:flutter/material.dart';
import 'package:flutter_application_task1/model/book.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddBooks extends StatefulWidget {
  final Book? book;
  const AddBooks({required this.book, Key? key}) : super(key: key);

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late Book newbook;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  void initState() {
    newbook = widget.book ?? Book(nameBook: "", author: "", dateTime: DateTime.now());

    _nameController.text = newbook.getnameBook;
    _authorController.text = newbook.getauthor;


    super.initState();
  }

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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          "edit add",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: "name",
                    decoration: const InputDecoration(
                      labelText: "set a name",
                      hintText: "set a name",
                      icon: Icon(Icons.book),),
                    controller: _nameController, // Use the TextEditingController
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      newbook.setnameBook = newValue!;
                    },
                  ),
                  FormBuilderTextField(
                    name: "author",
                    decoration: const InputDecoration(
                      labelText: "set author",
                      hintText: "set author",
                      icon: Icon(Icons.face),
                    ),
                    controller: _authorController, // Use the TextEditingController
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter author';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      newbook.setauthor = newValue!;
                    },
                  ),
                  FormBuilderDateTimePicker(
                    initialValue: newbook.getdateTime, 
                    name: 'date_field',
                    decoration: const InputDecoration(labelText: 'Select a date'),
                    validator: (value) {
                      if (value == null) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
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
