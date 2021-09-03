import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

class Database {
  FirebaseFirestore fireStore;
  initiliase() {
    fireStore = FirebaseFirestore.instance;
  }

  dynamic data;
  bool isAdded;

  Future<dynamic> getUserDetails(String id, BuildContext context) async {
    DocumentSnapshot documentSnapshot =
        await fireStore.collection('userDetails').doc(id).get();

    if (documentSnapshot.exists) {
      print('Document data: ${documentSnapshot.data()}');
      data = documentSnapshot.data();
    } else {
      print('Document does not exist on the database');
      data = documentSnapshot.data();
    }

    return data;
  }

  Future<bool> createAPost(String senderMailAddress, String receiverMailAddress,
      String placeType, String placeId) async {
    fireStore
        .collection('letters')
        .add({
          'senderEmailAddress': senderMailAddress,
          'receiverEmailaddress': receiverMailAddress,
          'placeType': placeType,
          'placeId': placeId
        })
        .then((value) => isAdded = true)
        .catchError((error) => isAdded = false);

    print(isAdded);

    return isAdded;
  }
}
