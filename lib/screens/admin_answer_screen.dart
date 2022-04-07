import 'package:flutter/material.dart';
import 'admin_answer_form.dart';
import 'app_bar.dart';


class AnswerScreen extends StatefulWidget {

  final String currrentDescription;
  final String currrentImageURL;
  final String documentId;
  final String currentAnswer;

  const AnswerScreen({
    required this.currrentDescription,
    required this.currrentImageURL,
    required this.documentId,
    required this.currentAnswer,
  });

  @override
  State<AnswerScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<AnswerScreen> {
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _answerFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        _descriptionFocusNode.unfocus();
        _answerFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 2,
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 29, 177, 152),
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
                answerFocusNode: _answerFocusNode,
                currentAnswer: widget.currentAnswer,
              ),
            )),
      ),
    );
  }
}