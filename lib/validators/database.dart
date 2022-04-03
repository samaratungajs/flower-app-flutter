import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _filestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _filestore.collection('notes');

class Database {
  static String? userId;

  static Future<void> addItem({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection("items").doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note item inserted to the database"))
        .catchError((e) => print(e));
  }

/////Update Item
  static Future<void> updatedItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection("items").doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };
    print(userId! + "And" + docId);
    await documentReference
        .set(data)
        .whenComplete(() => print("Note item updated to the database"))
        .catchError((e) => print(e));
  }

  /////Read Data
  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemscollection =
        _mainCollection.doc(userId).collection('items');
    return notesItemscollection.snapshots();
  }

  /////Delete Item
  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('items').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Note item delete fromm the database"))
        .catchError((e) => print(e));
  }

//add flower details
  static Future<void> addFlowerItem(
      {required String title, required String description}) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('flower').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note flower items inserted to the database"))
        .catchError((e) => print(e));
  }

//update flower items
  static Future<void> updateFlowerItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('flower').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note flower items updated to the database"))
        .catchError((e) => print(e));
  }

//Display all flower items
  static Stream<QuerySnapshot> readFlowerItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userId).collection('flower');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteFlowerItem({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('flower').doc(docId);

    await documentReference
        .delete()
        .whenComplete(
            () => print("Note flower item is deleted from the data base"))
        .catchError((e) => print(e));
  }
}
