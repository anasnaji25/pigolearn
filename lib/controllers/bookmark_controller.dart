





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pigolearn_round1/controllers/search_controller.dart';

class BookMarkController extends GetxController{

  RxBool isItemBookMarked = false.obs;
 
final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  bookMarkTheWord(String word,String meaning,String example, String image){
   _user = _auth.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc(_user.uid).collection("bookmarks").add({
            'userId': _user.uid,
            'word': word,
            'meaning': meaning,
            "example": example,
            "image": image
          });
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getBookMarks(){
      _user = _auth.currentUser!;
    Stream<QuerySnapshot<Map<String, dynamic>>> bookmarks = FirebaseFirestore.instance.collection('users').doc(_user.uid).collection("bookmarks").snapshots();
    return bookmarks;
  }


  deleteFromBookMarks(var docId) async{
     _user = _auth.currentUser!;
    await FirebaseFirestore.instance.collection('users').doc(_user.uid).collection("bookmarks").doc(docId).delete();
  }
  
}