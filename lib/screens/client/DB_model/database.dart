import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _filestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _filestore.collection('notes');

class Database {

  static String? userId = "admin";
  
  /////Read Data
  static Stream<QuerySnapshot> readCategories(String? keyword) {
    if (keyword != "" && keyword != null) {
      CollectionReference notesItemscollection =
          _mainCollection.doc("admin").collection('items');
      return notesItemscollection
          .where("title", isGreaterThanOrEqualTo:keyword)
          .where("title", isLessThanOrEqualTo:keyword + 'z')
          .snapshots();
    }
    else{
      CollectionReference notesItemscollection =
          _mainCollection.doc("admin").collection('items');
      return notesItemscollection
          .snapshots();
    }
  }

  //Q & A forum
  static Future<void> addForum({
    required String title,
    required String description,
    required String origin,
    required String imageURL,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "Question": title,
      "Answer": description,
      "Userid": userId,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note item inserted to the database"))
        .catchError((e) => print(e));
  }


//post question
  static Future<void> addImage({
    required String description,
    required String imageURL,
  }) async {
    DocumentReference documentReference =
    _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "description": description,
      "imageURL": imageURL,
      "answer":""

    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note item inserted to the database"))
        .catchError((e) => print(e));
  }


/////Update Item
  static Future<void> updatedForum({
    required String description,
    required String imageURL,
    required String docId,
  }) async {
    DocumentReference documentReference =
    _mainCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "description": description,
      "imageURL": imageURL,
      "answer" : ""
    };
    print(userId! + "And" + docId);
    await documentReference
        .set(data)
        .whenComplete(() => print("Note item updated to the database"))
        .catchError((e) => print(e));
  }

  /////Answer question
  static Future<void> answerQuestion({
    required String description,
    required String imageURL,
    required String docId,
    required String answer,

  }) async {
    DocumentReference documentReference =
    _mainCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "description": description,
      "imageURL": imageURL,
      "answer": answer,
    };
    print(userId! + "And" + docId);
    await documentReference
        .set(data)
        .whenComplete(() => print("Note answered to the question"))
        .catchError((e) => print(e));
  }


  /////Read Data
  static Stream<QuerySnapshot> readForum() {
    return _mainCollection.snapshots();
  }

/////Read one question
//   static Stream<QuerySnapshot> readEachQuestion(docId) {
//     CollectionReference notesItemscollection =
//     _mainCollection.doc(docId) as CollectionReference<Object?>;
//     return notesItemscollection
//         .snapshots();
//   }


  /////Delete Item
  static Future<void> deleteForum({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Note item delete fromm the database"))
        .catchError((e) => print(e));
  }


}
