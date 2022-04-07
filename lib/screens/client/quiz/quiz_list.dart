import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/admin/quiz/edit_quiz_screen.dart';
import 'package:crud_app/screens/admin/quiz/view_question_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class QuizList extends StatelessWidget {
  QuizList();

  // final String? keyword;
  bool _isShown = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.viewQuestions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 73, 209, 180)),
            ),
          );
        }

        return SizedBox(
          height: 600,
          child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
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
                          leading: Icon(Icons.contact_support_rounded),
                          title: Text(
                            question,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          // subtitle: Column(
                          //   children: [
                          //     Text(
                          //       answer,
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.w700,
                          //           color: Color.fromARGB(255, 13, 145, 72)
                          //               .withOpacity(0.6)),
                          //     ),
                          //     Text(
                          //       wrongAnswer,
                          //       style: TextStyle(
                          //           color: Color.fromARGB(255, 180, 48, 15)
                          //               .withOpacity(0.6)),
                          //     ),
                          //   ],
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            description,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        // Image.network('https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                        // Image.network(imageURL ??
                        //     'https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                      CachedNetworkImage(
                        // width: 200,
                        imageUrl: imageURL,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
