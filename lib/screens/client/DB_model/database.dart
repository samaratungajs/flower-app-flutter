import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore _filestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _filestore.collection('notes');

class Database {
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

}
