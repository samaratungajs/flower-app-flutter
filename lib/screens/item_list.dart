import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/edit_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemList extends StatelessWidget {
  ItemList(this.keyword);

  final String? keyword;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:Database.readItems(keyword),
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
              String title = noteInfo["title"];
              String description = noteInfo["description"];

              return Ink(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 96, 139, 126),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        currentTitle: title,
                        currrentDescription: description,
                        documentId: docId,
                      ),
                    ),
                  ),
                  title: Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
          ),
        );
      },
    );
  }
}
