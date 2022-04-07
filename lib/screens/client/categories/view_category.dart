import 'package:cached_network_image/cached_network_image.dart';
import 'package:crud_app/screens/admin/category/app_bar.dart';
import 'package:crud_app/screens/admin/category/edit_item_form.dart';
import 'package:flutter/material.dart';

class ViewCategory extends StatefulWidget {
  final String currentTitle;
  final String currrentDescription;
  final String currrentOrigin;
  final String currrentImageURL;
  final String documentId;

  const ViewCategory({
    required this.currentTitle,
    required this.currrentDescription,
    required this.currrentOrigin,
    required this.currrentImageURL,
    required this.documentId,
  });

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _originFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 2,
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          centerTitle: true,
          title: const AppBarTitle(
            sectionName: "Category Detail",
          ),
          
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0, bottom: 20.0),
          child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5), // Border width
                      // decoration: BoxDecoration(
                      //     color: Color.fromARGB(255, 29, 177, 152),
                      //     borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          //crossAxisAlignment: center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                  width: double.infinity, 
                                  height:300,// Image radius
                                  child: widget.currrentImageURL == null
                                      ? Image.network(
                                          "https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg",
                                          fit: BoxFit.cover)
                                      : CachedNetworkImage(
                                        imageUrl: widget.currrentImageURL,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),),
                            ),
                            ListTile(
                          leading: Icon(Icons.star_border_purple500_rounded),
                          title: Text(
                            widget.currentTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                              "Origins: ",
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Color.fromARGB(255, 78, 78, 78)),
                            ),
                            Text(
                              widget.currrentOrigin,
                              style: TextStyle(color: Color.fromARGB(255, 56, 56, 56),fontSize: 17),
                            ),
                            ], 
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:16.0, right: 16.0,),
                          child: Text(
                            widget.currrentDescription,
                            textAlign: TextAlign.justify,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13,),
                          ),
                        ),
                          ]),
                    ),
          
        )),
      ),
    );
  }
}
