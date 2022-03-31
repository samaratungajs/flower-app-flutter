import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/edit_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemList extends StatelessWidget {
  ItemList(this.keyword);

  final String? keyword;

   bool _isShown = true;


  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the box?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    setState(() {
                      _isShown = false;
                    });

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
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readItems(keyword),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 73, 209, 180)),
          ),
        );
          
        }

       return  SizedBox(
         height: 600,
         child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
                var noteInfo =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              String docId = snapshot.data!.docs[index].id;
              String title = noteInfo["title"];
              String description = noteInfo["description"];
              return Ink(
                  child:  Card(
                    elevation: 7,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.arrow_drop_down_circle),
                    title: Text(snapshot.data!.docs[index]['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                    TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 202, 55)),
                          ),
                          onPressed: ()=>Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditScreen(
                                  currentTitle: title,
                                  currrentDescription: description,
                                  documentId: docId,
                                ),
                              ),
                            ),
                          child: Text('Edit'),
                        ),
                      
                      TextButton(
                          style: ButtonStyle(
                            
                            foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 243, 33, 33)),
                          ),
                          onPressed: _isShown == true ? () => _delete(context) : null,
                          child: Text('Delete'),
                        )
                    ],
                  ),
                 // Image.network('https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                  CachedNetworkImage(
                    imageUrl: snapshot.data!.docs[index]['imageURL'],
                    progressIndicatorBuilder: (context, url, downloadProgress) => 
                    CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
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
