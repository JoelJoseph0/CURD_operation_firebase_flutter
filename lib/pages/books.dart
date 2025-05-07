import 'package:book_stash/service/database.dart';
import 'package:book_stash/utils/toast.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Book"),
        centerTitle: true,
      ),
      body: Container(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Title",style: TextStyle(color: Colors.black,fontSize: 20),),
            ),
    SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
          border: Border.all(),borderRadius: BorderRadius.circular(20)
        ),
              margin: EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20,),
    
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Price",style: TextStyle(color: Colors.black,fontSize: 20),),
            ),
    SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
          border: Border.all(),borderRadius: BorderRadius.circular(20)
        ),
              margin: EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20,),
    
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Author",style: TextStyle(color: Colors.black,fontSize: 20),),
            ),
    SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
          border: Border.all(),borderRadius: BorderRadius.circular(20)
        ),
              margin: EdgeInsets.only(left: 20,top: 10,right: 20),
              child: TextField(
                controller: authorController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20,),
    
    
            Center(
              child: OutlinedButton(onPressed: ()async{
                String id = randomAlphaNumeric(10);
    
                Map<String,dynamic> bookInfoMap = {
                  "Title" : titleController.text,
                  "Price" : priceController.text,
                  "Author" : authorController.text,
                  "Id" : id
                };
    
                await DatabaseHelper().addBookDetails(bookInfoMap, id).then((value){
                  Message.show(message: "Book Added Successfully");
                  Navigator.of(context).pop();
                });
              }, 
              child: Text("Add")),
            )
          ],
        ),
      ),
    );
  }
}