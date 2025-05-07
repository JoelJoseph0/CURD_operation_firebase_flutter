import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper{

  // Add book details
  Future addBookDetails(Map<String,dynamic> bookInfoMap, String id) async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).set(bookInfoMap);
  }


  // Retrieve Book Details
  Future<Stream<QuerySnapshot>> getAllBooksDetails() async{
    return await FirebaseFirestore.instance.collection("Books").snapshots();
  }



  // Update operation
  Future updateBook(String id, Map<String,dynamic> updateDetails) async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).update(updateDetails);
  }


  // Delete operation
  Future deleteBook(String id) async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).delete();
  }
}