import 'package:book/books.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:book/detailscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books',
      theme: new ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of Books'),
        ),
        body: Container(
          child: MainScreen(),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final Books book;

  const MainScreen({Key key, this.book}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List bookList;
  double screenHeight = 0.00, screenWidth = 0.00;
  String titlecenter = "Loading Books...";
  int starCount = 5;
  double rating = 0.00;

  @override
  void initState() {
    super.initState();
    _loadBook();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          bookList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900]),
                ))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: (screenWidth / screenHeight) / 0.3,
                  children: List.generate(bookList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(3),
                        child: Card(
                          child: InkWell(
                            onTap: () => _loadBookDetail(index),
                            child: Row(
                              children: [
                                Container(
                                    height: screenHeight / 0.5,
                                    width: screenWidth / 2.9,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://slumberjer.com/bookdepo/bookcover/${bookList[index]['cover']}.jpg",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 2,
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                      child:Text(
                                        bookList[index]['booktitle'],
                                        style: TextStyle(
                                          fontFamily: "Times New Roman",
                                          fontSize:16,
                                          fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                        ],
                                       ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Rating: " + bookList[index]['rating'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Author : " + bookList[index]['author'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "RM " + bookList[index]['price'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  }),
                ))
        ],
      ),
    );
  }

  void _loadBook() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php", body: {
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        bookList = null;
        setState(() {
          titlecenter = "No Book Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          bookList = jsondata["books"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadBookDetail(int index) {
    print(bookList[index]['booktitle']);
    Books book = new Books(
        bookid: bookList[index]['bookid'],
        booktitle: bookList[index]['booktitle'],
        author: bookList[index]['author'],
        price: bookList[index]['price'],
        description: bookList[index]['description'],
        rating: bookList[index]['rating'],
        publisher: bookList[index]['publisher'],
        isbn: bookList[index]['isbn'],
        cover: bookList[index]['cover']);

    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => DetailsScreen(book: book,)
        ));
  }
}