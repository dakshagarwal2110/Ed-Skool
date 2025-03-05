import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class AddDataToStorage {
  Future<String> uploadImageToStorage( String time , Uint8List file) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String childName = (preferences.getString('code') ?? "");

    Reference ref = storage.ref().child(childName).child(time);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    //print("whoooowowo $downloadUrl");
    return downloadUrl;
  }

  Future<String> saveData(
      {required String caption, required Uint8List file , required String time}) async {
    String resp = "Some error occurred";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {

      if(caption.isNotEmpty){
        String imageUrl = await uploadImageToStorage(time , file);
        await firebaseFirestore
            .collection("Schools").doc(preferences.getString('code'))
            .collection("announcement")
            .add({'caption': caption, 'imageUrl': imageUrl, 'timeInMillis' : time});
        resp = "Success";
      }else{
        String imageUrl = await uploadImageToStorage(time , file);
        await firebaseFirestore
            .collection("Schools").doc(preferences.getString('code'))
            .collection("announcement")
            .add({'caption': ".", 'imageUrl': imageUrl, 'timeInMillis' : time});
        resp = "Success";
      }

    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  Future<String> saveDataWithoutImage(
      {required String caption , required String time}) async {
    String resp = "Some error occurred";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {

      if(caption.isNotEmpty){

        await firebaseFirestore
            .collection("Schools").doc(preferences.getString('code'))
            .collection("announcement")
            .add({'caption': caption, 'imageUrl': "nothing" , 'timeInMillis' : time});
        resp = "Success";
      }else{
        await firebaseFirestore
            .collection("Schools").doc(preferences.getString('code'))
            .collection("announcement")
            .add({'caption': ".", 'imageUrl': "nothing", 'timeInMillis' : time});
        resp = "Success";
      }

    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
