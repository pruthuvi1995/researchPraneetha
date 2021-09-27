import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Utils.dart';
import 'providers/letter.dart';
// import 'package:flutter/material.dart';

class Database {
  FirebaseFirestore fireStore;
  initiliase() {
    fireStore = FirebaseFirestore.instance;
  }

  bool isAdded;

  Future<dynamic> getUserDetails(String id, BuildContext context) async {
    dynamic data;
    DocumentSnapshot documentSnapshot;

    try {
      documentSnapshot =
          await fireStore.collection('userDetails').doc(id).get();

      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        data = documentSnapshot.data();
      } else {
        print('Document does not exist on the database');
        data = documentSnapshot.data();
      }

      return data;
    } catch (error) {
      print(error);
    }
  }

  Stream<List<Letter>> getReceiverEmails(String email, BuildContext context) =>
      fireStore
          .collection('letters')
          .where('receiverMailAddress', isEqualTo: email)
          .snapshots()
          .transform(Utils.transformer(Letter.fromJson));

  Future deleteReceiverLetter(Letter letter) async {
    final docLetter = fireStore.collection('letters').doc(letter.id);

    await docLetter.delete();
  }

  Future<void> updateUserDetails(
      String id, String firstName, BuildContext context) async {
    try {
      await fireStore
          .collection('userDetails')
          .doc(id)
          .update({"firstName": firstName});
    } catch (error) {
      print(error);
    }
  }

  Future<void> createUserDetails(String address, String email, String firstName,
      String lastName, String postBoxId) async {
    try {
      await fireStore.collection('userDetails').doc(email).set({
        "address": address,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "postBoxId": postBoxId,
      }).whenComplete(() => print('user details are updated.'));
    } catch (error) {
      print(error);
    }
  }

  Future<void> createPost(String senderMailAddress, String receiverMailAddress,
      String placeType, String placeId) async {
    try {
      final docLetter = fireStore.collection('letters').doc();

      await docLetter.set({
        "id": docLetter.id,
        "senderMailAddress": senderMailAddress,
        "receiverMailAddress": receiverMailAddress,
        "placeType": placeType,
        "placeId": placeId,
      });
    } catch (error) {
      print(error);
    }
  }
}
