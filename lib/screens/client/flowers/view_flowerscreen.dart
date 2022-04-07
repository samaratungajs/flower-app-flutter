import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewFlowerScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String currentImageURL;
  final String documentId;

  ViewFlowerScreen(
      {required this.currentTitle,
      required this.currentDescription,
      required this.currentImageURL,
      required this.documentId});

  @override
  State<ViewFlowerScreen> createState() => _ViewFlowerScreenState();
}

class _ViewFlowerScreenState extends State<ViewFlowerScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            elevation: 2,
            toolbarHeight: 70,
            backgroundColor: Color.fromARGB(255, 29, 177, 152),
            title: const Text("Flower  Details")),
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
                      widget.currentTitle,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        widget.currentDescription,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Color.fromARGB(255, 13, 145, 72)
                                .withOpacity(0.6)),
                      ),
                    ],
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
                  imageUrl: widget.currentImageURL,
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
