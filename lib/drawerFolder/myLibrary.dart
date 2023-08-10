import 'package:flutter/material.dart';
import 'package:flutter_application_task1/model/book.dart';
import 'package:flutter_application_task1/restfullApi/getApi.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({Key? key}) : super(key: key);

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
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

  @override
  void initState() {
    fetchData([categories.first]).then((dataList) {
      setState(() {
        dataListBook = dataList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "My Library",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return Container(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue[500],
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
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dataListBook.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        // Define the shape of the card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        // Define how the card's content should be clipped
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        // Define the child widget of the card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Add padding around the row widget
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dataListBook[index].getimage != ''
                                      ? Image.network(
                                          dataListBook[index].getimage,
                                          height: 130,
                                          width: 100,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          "./assets/images/PNG2105.png",
                                          height: 130,
                                          width: 100,
                                          fit: BoxFit.fill,
                                        ),
                                  // Add some spacing between the image and the text
                                  Container(width: 20),
                                  // Add an expanded widget to take up the remaining horizontal space
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Add some spacing between the top of the card and the title
                                        Container(height: 5),
                                        // Add a title widget
                                        Text(
                                          dataListBook[index].getnameBook,
                                        ),
                                        // Add some spacing between the title and the subtitle
                                        Container(height: 5),
                                        // Add a subtitle widget
                                        Text(
                                          dataListBook[index].getauthor,
                                        ),
                                        // Add some spacing between the subtitle and the text
                                        Container(height: 10),
                                        // Add a text widget to display some text
                                        Text(
                                          dataListBook[index]
                                                  .getdateTime
                                                  .toString() ??
                                              "no date ",
                                          maxLines: 2,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Spacer(),
                                            // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.transparent,
                                              ),
                                              child: const Text(
                                                "EXPLORE",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              onPressed: () {
                                                (dataListBook[index]
                                                    .getinfolink);
                                              },
                                            ),
                                          ],
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
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
