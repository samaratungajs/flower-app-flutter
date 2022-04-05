import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/edit_quiz_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class QuestionList extends StatelessWidget {
  QuestionList(this.keyword);

  final String? keyword;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:Database.readQuestions(keyword),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 25.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noteInfo =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              String docId = snapshot.data!.docs[index].id;
              String question = noteInfo["question"];
              String answer = noteInfo["answer"];
              String wrongAnswer = noteInfo["wrongAnswer"];
              String description = noteInfo["description"];
              String? imageURL = noteInfo["imageURL"];

              return Ink(
                child:  Card(
                  elevation: 7,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text(question, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  // subtitle: Text(
                  //   'Secondary Text',
                  //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                      textColor:Color.fromARGB(255, 29, 177, 152),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('Update',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                    ),
                    FlatButton(
                      textColor: Color.fromARGB(255, 29, 177, 152),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('Delete',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.red)),
                    ),
                  ],
                ),
               // Image.network('https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                Image.network(imageURL ?? 'https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
              ],
            ),
          ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 73, 209, 180)),
          ),
        );
      },
    );
  }
}
