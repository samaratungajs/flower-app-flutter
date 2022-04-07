import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/edit_fscreen.dart';
import 'package:crud_app/screens/view_flowerscreen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemListUser extends StatelessWidget {
  const ItemListUser(this.keyword);

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
                                  builder: (context) => ViewFlowerScreen(
                                    currentTitle: title,
                                    currentDescription: description,
                                    currentImageURL: imageURL,
                                    documentId: docId,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('View'), // <-- Text
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Image.network('https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),

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
