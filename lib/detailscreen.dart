import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'books.dart';

class DetailsScreen extends StatefulWidget {
  final Books book;

  const DetailsScreen({Key key, this.book}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.booktitle),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: screenHeight / 2.0,
                    width: screenWidth / 0.5,
                    child: SingleChildScrollView(
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://slumberjer.com/bookdepo/bookcover/${widget.book.cover}.jpg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                      ),
                    )),
                Divider(color: Colors.red[900]),
                Text('Description',
                textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 10),
                Text(widget.book.description),
                Divider(color: Colors.red[900]),
                Container(
        color: Colors.white,
        padding: EdgeInsets.all(5),
        
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(children: [
              Text('CATEGORY' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
              Text('DETAIL' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
            ]),
            
            TableRow(children: [
              Text('Title' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
              Text(widget.book.booktitle),
            ]),

            TableRow(children: [
              Text('Rating' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
              Text(widget.book.rating),
            ]),

            TableRow(children: [
              Text('Author' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
              Text(widget.book.author),
            ]),

            TableRow(children: [
              Text('Price' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
              Text("RM " + widget.book.price),
            ]),
            
            TableRow(children: [
              Text('ISBN' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
              Text(widget.book.isbn),
            ]),
 
             TableRow(children: [
              Text('Publisher' , style: new TextStyle(
                        fontWeight: FontWeight.bold),),
              Text(widget.book.publisher),
            ]),

          ],
        ),
      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}