import 'package:crud_app/screens/app_bar.dart';
import 'package:crud_app/screens/edit_quiz_form.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewQuestionScreen extends StatefulWidget {
  final String currentQuestion;
  final String currentAnswer;
  final String currentWrongAnswer;
  final String currrentDescription;
  final String documentId;
  final String currrentImageURL;

  const ViewQuestionScreen({
    required this.currentQuestion,
    required this.currentAnswer,
    required this.currentWrongAnswer,
    required this.currrentDescription,
    required this.documentId,
    required this.currrentImageURL,
  });

  @override
  State<ViewQuestionScreen> createState() => _ViewQuestionScreenState();
}

class _ViewQuestionScreenState extends State<ViewQuestionScreen> {
  final FocusNode _questionFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _answerFocusNode = FocusNode();
  final FocusNode _wrongAnswerFocusNode = FocusNode();
  bool _isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 2,
          toolbarHeight: 70,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          title: const AppBarTitle(
            sectionName: "view Question",
          ),
        ),
        backgroundColor: Color.fromARGB(255, 170, 242, 252),
        body: Ink(
            child: Container(
          // width: 400,
          // height: 600,
          padding: new EdgeInsets.all(8.0),
          child: Card(
            elevation: 7,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  // leading: Icon(Icons.arrow_drop_down_circle),
                  title: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                    widget.currentQuestion,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        "Answer: "+widget.currentAnswer,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color.fromARGB(255, 13, 145, 72)
                                .withOpacity(0.6)),
                      ),
                      Text(
                        "Wrong Answer: "+widget.currentWrongAnswer,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color.fromARGB(255, 180, 48, 15)
                                .withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.currrentDescription,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                // ButtonBar(
                //   alignment: MainAxisAlignment.start,
                //   children: [
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         primary: Color.fromARGB(255, 15, 228, 26),
                //         shape: new RoundedRectangleBorder(
                //           borderRadius: new BorderRadius.circular(30.0),
                //         ),
                //       ),
                //       onPressed: () => Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => EditQuizScreen(
                //             currentQuestion: question,
                //             currentAnswer: answer,
                //             currentWrongAnswer: wrongAnswer,
                //             currrentDescription: description,
                //             currrentImageURL: imageURL,
                //             documentId: docId,
                //           ),
                //         ),
                //       ),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Text('View'), // <-- Text
                //           SizedBox(
                //             width: 3,
                //           ),
                //           Icon(
                //             // <-- Icon
                //             Icons.edit,
                //             size: 16.0,
                //           ),
                //         ],
                //       ),
                //     ),
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         primary: Colors.amber,
                //         shape: new RoundedRectangleBorder(
                //           borderRadius: new BorderRadius.circular(30.0),
                //         ),
                //       ),
                //       onPressed: () => Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => EditQuizScreen(
                //             currentQuestion: question,
                //             currentAnswer: answer,
                //             currentWrongAnswer: wrongAnswer,
                //             currrentDescription: description,
                //             currrentImageURL: imageURL,
                //             documentId: docId,
                //           ),
                //         ),
                //       ),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Text('Update'), // <-- Text
                //           SizedBox(
                //             width: 3,
                //           ),
                //           Icon(
                //             // <-- Icon
                //             Icons.edit,
                //             size: 16.0,
                //           ),
                //         ],
                //       ),
                //     ),
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           primary: Colors.redAccent,
                //           shape: new RoundedRectangleBorder(
                //             borderRadius: new BorderRadius.circular(30.0),
                //           )),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Text('Delete'), // <-- Text
                //           SizedBox(
                //             width: 3,
                //           ),
                //           Icon(
                //             // <-- Icon
                //             Icons.delete,
                //             size: 16.0,
                //           ),
                //         ],
                //       ),
                //       onPressed: () => showDialog(
                //           context: context,
                //           builder: (BuildContext ctx) {
                //             return AlertDialog(
                //               title: const Text('Please Confirm'),
                //               content:
                //                   Text("Are you sure to remove this question?"),
                //               actions: [
                //                 // The "Yes" button
                //                 TextButton(
                //                     onPressed: () async {
                //                       // Remove the box
                //                       // setState(() {
                //                       //   _isShown = false;
                //                       // });
                //                       await Database.deleteQuestion(
                //                         docId: docId,
                //                       );
                //                       child:
                //                       CircularProgressIndicator(
                //                         valueColor: AlwaysStoppedAnimation<Color>(
                //                             Colors.orangeAccent),
                //                         strokeWidth: 3,
                //                       );
                //                       // Close the dialog
                //                       Navigator.of(context).pop();
                //                     },
                //                     child: const Text('Yes')),
                //                 TextButton(
                //                     onPressed: () {
                //                       // Close the dialog
                //                       Navigator.of(context).pop();
                //                     },
                //                     child: const Text('No'))
                //               ],
                //             );
                //           }),
                //     )
                //   ],
                // ),
                // Image.network('https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                // Image.network( widget.currrentImageURL ?
                //     'https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                CachedNetworkImage(
                  width: 200,
                  imageUrl: widget.currrentImageURL,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
