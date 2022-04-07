
import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'edit_question_form.dart';

class EditScreen extends StatefulWidget {

  final String currrentDescription;
  final String currrentImageURL;
  final String documentId;

  const EditScreen({
    required this.currrentDescription,
    required this.currrentImageURL,
    required this.documentId,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _originFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        _originFocusNode.unfocus();
      },
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
          title: const AppBarTitle(
            sectionName: "Update Question",
          ),

        ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: EditItemForm(
                documentId: widget.documentId,
                descriptionFocusNode: _descriptionFocusNode,
                currentDescription: widget.currrentDescription,
                currentImageURL: widget.currrentImageURL,
              ),
            )),
      ),
    );
  }
}