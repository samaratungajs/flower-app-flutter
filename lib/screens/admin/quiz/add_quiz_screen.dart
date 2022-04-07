import 'package:crud_app/screens/admin/quiz/add_quiz_form.dart';
import 'package:crud_app/screens/app_bar.dart';
import 'package:flutter/material.dart';

class AddQuizScreen extends StatelessWidget {
  final FocusNode _questionFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _answerFocusNode = FocusNode();
  final FocusNode _wrongAnswerFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _questionFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        _answerFocusNode.unfocus();
        _wrongAnswerFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          toolbarHeight: 70,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          title: const AppBarTitle(
            sectionName: "Add Question",
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20),
          child: AddQuizForm(
              questionFocusNode: _questionFocusNode,
              answerFocusNode: _answerFocusNode,
              wrongAnswerFocusNode: _wrongAnswerFocusNode,
              descriptionFocusNode: _descriptionFocusNode),
        )),
      ),
    );
  }
}
