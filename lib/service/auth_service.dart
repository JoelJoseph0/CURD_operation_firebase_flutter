import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceHelper {
  static Future<String> createAccountWithEmail(
    String Email,
    String Password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }


// Login
  static Future<String> loginWithEmail(String Email, String Password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }


  // Logout

  static Future logout() async{
    try{
      await FirebaseAuth.instance.signOut();
    }on FirebaseAuthException catch(e){
      return e.message.toString();
    }
  }


  // Check User
  static Future<bool> isUserLoggedIn() async{
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null? true : false;
  }



}
