import 'package:cloud_firestore/cloud_firestore.dart';



final FirebaseFirestore _filestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection1 = _filestore.collection('forum');

class Database {
  static String? userId;
  static String? docId;

  static Future<void> addItem({
    required String title,
    required String description,
    required String origin,
    required String imageURL,
  }) async {
    DocumentReference documentReference =
        _mainCollection1.doc();

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
    _mainCollection1.doc();

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
  static Future<void> updatedItem({
    required String description,
    required String imageURL,
    required String docId,
  }) async {
    DocumentReference documentReference =
    _mainCollection1.doc(docId);

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
    _mainCollection1.doc(docId);

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
  static Stream<QuerySnapshot> readItems() {
    return _mainCollection1.snapshots();
  }

/////Read one question
//   static Stream<QuerySnapshot> readEachQuestion(docId) {
//     CollectionReference notesItemscollection =
//     _mainCollection1.doc(docId) as CollectionReference<Object?>;
//     return notesItemscollection
//         .snapshots();
//   }


  /////Delete Item
  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _mainCollection1.doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Note item delete fromm the database"))
        .catchError((e) => print(e));
  }
}
