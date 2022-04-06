import 'package:crud_app/screens/app_bar.dart';
import 'package:crud_app/screens/edit_fitem_form.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/validators/database.dart';

class EditScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String currentImageURL;
  final String documentId;
  EditScreen(
      {required this.currentTitle,
      required this.currentDescription,
      required this.currentImageURL,
      required this.documentId});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
          elevation: 2,
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          title: const AppBarTitle(
            sectionName: "Update Category",
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: EditItemForm(
              documentId: widget.documentId,
              titleFocusNode: _titleFocusNode,
              currentImageURL: widget.currentImageURL,
              descriptionFocusNode: _descriptionFocusNode,
              currentTitle: widget.currentTitle,
              currrentDescription: widget.currentDescription),
        )),
      ),
    );
  }
}
