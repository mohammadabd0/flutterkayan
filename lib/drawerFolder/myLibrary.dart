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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "My Library",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
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
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 65),
            child: ListView.builder(
              
              shrinkWrap: true,
              itemCount: dataListBook.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                    color: Colors.white,
                           
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
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
                                            "./assets/images/bookimge.png",
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
                                            dataListBook[index].getnameBook,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Container(height: 5),
                                          Text(
                                            dataListBook[index].getauthor,
                                          ),
                                          Container(height: 10),
                                          Text(
                                            dataListBook[index]
                                                    .getdateTime
                                                    .toString() ??
                                                "no date ",
                                            maxLines: 2,
                                          ),
                                            Container(height: 10),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: const Text(
                                                    "Explore",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255)),
                                                  ),
                                                  onPressed: () {
                                                    (dataListBook[index]
                                                        .getinfolink);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: const Text(
                                                    "Detail",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255)),
                                                  ),
                                                  onPressed: () {
                                                   
                                                  },
                                                ),
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
