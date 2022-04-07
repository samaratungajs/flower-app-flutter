import 'package:crud_app/screens/admin/category/app_bar.dart';
import 'package:crud_app/screens/admin/quiz/edit_quiz_form.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';

class EditQuizScreen extends StatefulWidget {
  final String currentQuestion;
  final String currentAnswer;
  final String currentWrongAnswer;
  final String currrentDescription;
  final String documentId;
  final String currrentImageURL;

  const EditQuizScreen({
    required this.currentQuestion,
    required this.currentAnswer,
    required this.currentWrongAnswer,
    required this.currrentDescription,
    required this.documentId,
    required this.currrentImageURL,
  });

  @override
  State<EditQuizScreen> createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  final FocusNode _questionFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _answerFocusNode = FocusNode();
  final FocusNode _wrongAnswerFocusNode = FocusNode();
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _questionFocusNode.unfocus();
        _answerFocusNode.unfocus();
        _wrongAnswerFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
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
          toolbarHeight: 70,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          title: const AppBarTitle(
            sectionName: "Update Quiz",
          ),
          actions: [
            _isDeleting
                ? SizedBox(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 6, 212, 178)),
                      strokeWidth: 3,
                    ),
                    height: 1,
                  )
                : IconButton(
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });
                      await Database.deleteItem(
                        docId: widget.documentId,
                      );
                      setState(() {
                        _isDeleting = false;
                      });
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.delete_sharp,
                      color: Colors.redAccent,
                      size: 32,
                    ))
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
          child: EditQuizForm(
              documentId: widget.documentId,
              questionFocusNode: _questionFocusNode,
              answerFocusNode: _answerFocusNode,
              wrongAnswerFocusNode: _wrongAnswerFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              currentQuestion: widget.currentQuestion,
              currentAnswer: widget.currentAnswer,
              currentWrongAnswer: widget.currentWrongAnswer,
              currentDescription: widget.currrentDescription,
              currentImageURL: widget.currrentImageURL,
),
        )),
      ),
    );
  }
}
