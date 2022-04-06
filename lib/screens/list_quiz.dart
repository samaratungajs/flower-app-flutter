import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/edit_quiz_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionList extends StatelessWidget {
  QuestionList(this.keyword);

  final String? keyword;
  bool _isShown = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readQuestions(keyword),
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
              String imageURL = noteInfo["imageURL"];

              return Ink(
                child: Card(
                  elevation: 7,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.arrow_drop_down_circle),
                        title: Text(
                          question,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              answer,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 13, 145, 72)
                                      .withOpacity(0.6)),
                            ),
                            Text(
                              wrongAnswer,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 180, 48, 15)
                                      .withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          description,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditQuizScreen(
                                  currentQuestion: question,
                                  currentAnswer: answer,
                                  currentWrongAnswer: wrongAnswer,
                                  currrentDescription: description,
                                  currrentImageURL: imageURL,
                                  documentId: docId,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Update'), // <-- Text
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  // <-- Icon
                                  Icons.edit,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                )),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Delete'), // <-- Text
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  // <-- Icon
                                  Icons.delete,
                                  size: 16.0,
                                ),
                              ],
                            ),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: const Text('Please Confirm'),
                                    content: Text(
                                        "Are you sure to remove this question?"),
                                    actions: [
                                      // The "Yes" button
                                      TextButton(
                                          onPressed: () async {
                                            // Remove the box
                                            // setState(() {
                                            //   _isShown = false;
                                            // });
                                            await Database.deleteQuestion(
                                              docId: docId,
                                            );
                                            child:
                                            CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.orangeAccent),
                                              strokeWidth: 3,
                                            );
                                            // Close the dialog
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            // Close the dialog
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'))
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                      // Image.network('https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                      // Image.network(imageURL ??
                      //     'https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 73, 209, 180)),
          ),
        );
      },
    );
  }
}
