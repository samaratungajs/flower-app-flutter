import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _filestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _filestore.collection('notes');

class Database {
  static String? userId;

  static Future<void> addItem({
    required String title,
    required String description,
    required String origin,
    required String imageURL,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection("items").doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "imageURL": imageURL,
      "origin": origin,          
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
    required String imageURL,
    required String docId,
    required String origin,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection("items").doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "origin": origin,
      "imageURL": imageURL,
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
          .where("title", isGreaterThanOrEqualTo:keyword)
          .where("title", isLessThanOrEqualTo:keyword + 'z')
          .snapshots();
    }
    else{
      CollectionReference notesItemscollection =
          _mainCollection.doc(userId).collection('items');
      return notesItemscollection
          .snapshots();
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


  //Quiz DB function
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

  ////view questions
  static Stream<QuerySnapshot> viewQuestions() {
      CollectionReference quizQuestionscollection =
          _mainCollection.doc('qwer1234').collection('quiz');
      return quizQuestionscollection.snapshots();
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




  //Q & A Forum
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



  //Flowers
  //add flower details
  static Future<void> addFlowerItem(
      {required String title,
      required String description,
      required String imageURL}) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('flower').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "imageURL": imageURL
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note flower items inserted to the database"))
        .catchError((e) => print(e));
  }

//update flower items
  static Future<void> updateFlowerItem(
      {required String title,
      required String description,
      required String docId,
      required String imageURL}) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('flower').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "imageURL": imageURL,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Note flower items updated to the database"))
        .catchError((e) => print(e));
  }

//Display all flower items
  static Stream<QuerySnapshot> readFlowerItems(String? keyword) {
    if (keyword != "" && keyword != null) {
      CollectionReference notesItemscollection =
          _mainCollection.doc(userId).collection('flower');
      return notesItemscollection
          .where("title", isGreaterThanOrEqualTo: keyword)
          .where("title", isLessThanOrEqualTo: keyword + 'z')
          .snapshots();
    } else {
      CollectionReference notesItemscollection =
          _mainCollection.doc(userId).collection('flower');
      return notesItemscollection.snapshots();
    }
  }

  static Future<void> deleteFlowerItems({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection.doc(userId).collection('flower').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Note item delete fromm the database"))
        .catchError((e) => print(e));
  }

  //Display all flower items to users
  static Stream<QuerySnapshot> readFlowerUserItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userId).collection('flower');

    return notesItemCollection.snapshots();
  }

}
