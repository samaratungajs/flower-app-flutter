import 'package:crud_app/screens/admin/flowers/edit_fitem_form.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/validators/database.dart';

class EditFScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String currentImageURL;
  final String documentId;
  EditFScreen(
      {required this.currentTitle,
      required this.currentDescription,
      required this.currentImageURL,
      required this.documentId});

  @override
  State<EditFScreen> createState() => _EditFScreenState();
}

class _EditFScreenState extends State<EditFScreen> {
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
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          )),
          elevation: 2,
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          title: const Text("Update  Details"),
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
