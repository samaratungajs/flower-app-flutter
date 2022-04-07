import 'package:crud_app/screens/admin/quiz/add_quiz_screen.dart';
import 'package:crud_app/screens/admin_header_with_search.dart';
import 'package:crud_app/screens/client/quiz_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/admin/quiz/edit_quiz_screen.dart';
import 'package:crud_app/screens/admin/quiz/view_question_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud_app/screens/app_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String name = "";
  final fieldText = TextEditingController();

  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  // PageController? _controller;
  String btnText = "Next Question";
  String answered = "";

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
        return Scaffold(
            body: Scaffold(
          appBar: AppBar(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            toolbarHeight: 75,
            backgroundColor: Color.fromARGB(255, 29, 177, 152),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.asset(
                //   'assets/whitelogo.png',
                //   height: 10,
                // ),
                const SizedBox(width: 8),
                Center(
                  child: Text(
                  "Flower Quiz",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                ),
                Center(
                  child: Text(
                  "Score: $score",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                ),
              ],
            ),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5),
              child: SizedBox(
                // height: 600,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      var noteInfo = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      // btnPressed = false;
                      // // PageController? _controller;
                      // answered = false;
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
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
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              CachedNetworkImage(
                                // width: 200,
                                imageUrl: imageURL,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Container(
                                width: double.infinity,
                                height: 50.0,
                                margin: EdgeInsets.only(
                                    bottom: 20.0,
                                    left: 12.0,
                                    right: 12.0,
                                    top: 12.0),
                                child: RawMaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  fillColor: answered == docId
                                      ? Color.fromARGB(255, 62, 226, 40)
                                      : Color.fromARGB(255, 5, 26, 43),
                                  // : AppColor.secondaryColor,
                                  onPressed: answered != docId
                                      ? () {
                                          score++;
                                          print("yes");
                                          setState(() {
                                            btnPressed = true;
                                            answered = docId;
                                          });
                                        }
                                      : null,
                                  child: Text(answer,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      )),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 50.0,
                                margin: EdgeInsets.only(
                                    bottom: 20.0, left: 12.0, right: 12.0),
                                child: RawMaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  fillColor: answered == docId
                                      ? Color.fromARGB(255, 245, 79, 29)
                                      : Color.fromARGB(255, 5, 26, 43),
                                  // : AppColor.secondaryColor,
                                  onPressed: answered != docId
                                      ? () {
                                          print("no");
                                          setState(() {
                                            btnPressed = true;
                                            answered = docId;
                                          });
                                        }
                                      : null,
                                  child: Text(wrongAnswer,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      )),
                                ),
                              ),
                              // Image.network('https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                              // Image.network(imageURL ??
                              //     'https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ));
      },
    );
  }
}
