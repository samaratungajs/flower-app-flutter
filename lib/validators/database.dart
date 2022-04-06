import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _filestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _filestore.collection('notes');

class Database {
  static String? userId;

  static Future<void> addItem({
    required String title,
    required String description,
    required String imageURL,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection("items").doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "imageURL": imageURL,
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
  static Stream<QuerySnapshot> readItems(String? keyword) {
    if (keyword != "" && keyword != null) {
      CollectionReference notesItemscollection =
          _mainCollection.doc(userId).collection('items');
      return notesItemscollection
          .where("title", isGreaterThanOrEqualTo: keyword)
          .where("title", isLessThanOrEqualTo: keyword + 'z')
          .snapshots();
    } else {
      CollectionReference notesItemscollection =
          _mainCollection.doc(userId).collection('items');
      return notesItemscollection.snapshots();
    }
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

  ////////////////quiz
  //add questions
  static Future<void> addQuestion({
    required String question,
    required String wrongAnswer,
    required String answer,
    required String description,
    required String imageURL,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection("quiz").doc();

    Map<String, dynamic> data = <String, dynamic>{
      "question": question,
      "answer": answer,
      "wrongAnswer": wrongAnswer,
      "description": description,
      "imageURL": imageURL,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note item inserted to the database"))
        .catchError((e) => print(e));
  }

/////Update question
  static Future<void> updateQuestion({
    required String question,
    required String wrongAnswer,
    required String answer,
    required String description,
    required String imageURL,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection("quiz").doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "question": question,
      "answer": answer,
      "wrongAnswer": wrongAnswer,
      "description": description,
      "imageURL": imageURL,
    };
    print(userId! + "And" + docId);
    await documentReference
        .set(data)
        .whenComplete(() => print("Quiz question updated to the database"))
        .catchError((e) => print(e));
  }

  /////Read question
  static Stream<QuerySnapshot> readQuestions(String? keyword) {
    if (keyword != "" && keyword != null) {
      CollectionReference quizQuestionscollection =
          _mainCollection.doc(userId).collection('quiz');
      return quizQuestionscollection
          .where("question", isGreaterThanOrEqualTo: keyword)
          .where("question", isLessThanOrEqualTo: keyword + 'z')
          .snapshots();
    } else {
      CollectionReference quizQuestionscollection =
          _mainCollection.doc(userId).collection('quiz');
      return quizQuestionscollection.snapshots();
    }
  }

  /////Delete question
  static Future<void> deleteQuestion({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('quiz').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Quiz question deleted from the database"))
        .catchError((e) => print(e));
  }
}
