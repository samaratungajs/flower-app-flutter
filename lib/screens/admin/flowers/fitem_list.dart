import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/admin/category/edit_screen.dart';
import 'package:crud_app/screens/admin/flowers/edit_fscreen.dart';
import 'package:crud_app/screens/client/q&a_forum/edit_question_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemList extends StatelessWidget {
  const ItemList(this.keyword);

  final String? keyword;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readFlowerItems(keyword),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('something went wrong');
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
                String title = noteInfo["title"];
                String description = noteInfo["description"];
                String imageURL = noteInfo["imageURL"];

                return Ink(
                  child: Card(
                    margin: EdgeInsets.only(bottom: 30.0),
                    elevation: 15,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.arrow_drop_down_circle),
                          title: Text(snapshot.data!.docs[index]['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Text(
                            description,
                            maxLines: 4,
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
                                  builder: (context) => EditFScreen(
                                    currentTitle: title,
                                    currentDescription: description,
                                    currentImageURL: imageURL,
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
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
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
                                          "Are you sure you want to delete $title flower?"),
                                      actions: [
                                        // The "Yes" button
                                        TextButton(
                                            onPressed: () async {
                                              // Remove the box
                                              // setState(() {
                                              //   _isShown = false;
                                              // });
                                              await Database.deleteFlowerItems(
                                                docId: docId,
                                              );
                                              child:
                                              CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
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
                        CachedNetworkImage(
                          imageUrl: snapshot.data!.docs[index]['imageURL'],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                        //Image.network(snapshot.data!.docs[index]['imageURL'] ?? 'https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
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
