import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message{
  static void show(
    {
      String message = "Done!",
    }
  ){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0
              );
  }
}