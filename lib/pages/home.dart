import 'package:book_stash/pages/books.dart';
import 'package:book_stash/service/database.dart';
import 'package:book_stash/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController authorController = TextEditingController();

Stream? bookStream;

dynamic getInfoInit() async {
  bookStream = await DatabaseHelper().getAllBooksDetails();
  setState(() {
    
  });
}

@override
  void initState() {
    getInfoInit();
    super.initState();
  }

  Widget allBooksInfo(){
    return StreamBuilder(
      stream: bookStream, 
    builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
          return Container(
            margin: EdgeInsets.only(bottom: 21),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.book_rounded,size: 40,color: Colors.grey,),
                          InkWell(
                            onTap: (){
                              titleController.text = documentSnapshot["Title"];
                              priceController.text = documentSnapshot["Price"];
                              authorController.text = documentSnapshot["Author"];

                              editBook(documentSnapshot["Id"]);
                            },
                            child: Icon(Icons.edit_document,size: 45, color: const Color.fromARGB(255, 214, 212, 212),)),

                            InkWell(
                              onTap: (){
                                showDeleteInformationDialogue(context, documentSnapshot["Id"]);
                              },
                              child: Icon(Icons.delete_forever,size: 45,color: Colors.brown,))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Title: ${documentSnapshot["Title"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("Price: ${documentSnapshot["Price"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("Author: ${documentSnapshot["Author"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    ],
                  ),
                ),
              ),
          );
        },
      ) : Container();
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Stash"),
        centerTitle: true,
      ),
      body: Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 25),
        child: Column(
          children: [
            Expanded(child: allBooksInfo()),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Books()));
      },
      child: Icon(Icons.add),),
    );
  }



  Future editBook(String id){
    return showDialog(context: context, builder: (context)=> AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Edit a Book",style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.cancel_outlined,size: 35,color: Colors.blueGrey,))
              ],
            ),
            Divider(thickness: 3,color: Colors.black,),
        
            SizedBox(height: 20,),
        
        
            
        Column(
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
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(onPressed: () async{
                    Map<String,dynamic> updateDetails = {
                      "Title" : titleController.text,
                      "Price" : priceController.text,
                      "Author" : authorController.text,
                      "Id" : id
                    };
        
                    await DatabaseHelper().updateBook(id, updateDetails).then((value){
                      Message.show(message: "Book has been updated");
                      Navigator.pop(context);
                    });
                  }, child: Text("Update")),
        
                  OutlinedButton(onPressed: (){
                    Navigator.pop(context);
                  },  child: Text("Cancel")),
                ],
              )
          ],
        
          
        ),
          ],
        ),
      )
    )
  );
  }




  void showDeleteInformationDialogue(BuildContext context, String id){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Sure you want to delete the book"),
        actions: [
          TextButton(onPressed: () async{
            await DatabaseHelper().deleteBook(id);
            Navigator.pop(context);
          }, child: Text("Delete")),

          TextButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, child: Text("No")),
        ],
      );
    });
  }


}