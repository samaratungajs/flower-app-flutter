import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/admin/category/edit_screen.dart';
import 'package:crud_app/screens/client/DB_model/database.dart';
import 'package:crud_app/screens/client/categories/view_category.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryItem  extends StatelessWidget {
  CategoryItem (this.keyword);

  final String? keyword;

  bool _isShown = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readCategories(keyword),
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
                String title = noteInfo["title"];
                String description = noteInfo["description"];
                String origin = noteInfo["origin"];
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
                          title: Text(
                            snapshot.data!.docs[index]['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                              "Origins: ",
                              style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black.withOpacity(0.6)),
                            ),
                            Text(
                              origin,
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                            ], 
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:16.0, right: 16.0,),
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
                               primary: Color.fromARGB(255, 43, 43, 43),
                               shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                             ), 
                             ),
                             onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViewCategory(
                                    currentTitle: title,
                                    currrentDescription: description,
                                    currrentImageURL: imageURL,
                                    currrentOrigin: origin,
                                    documentId: docId,
                                  ),
                                ),
                             ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('View'), // <-- Text
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon( // <-- Icon
                                    Icons.view_agenda_rounded,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                            
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
                        ),
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
