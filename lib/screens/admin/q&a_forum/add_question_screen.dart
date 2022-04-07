import 'package:crud_app/screens/admin/category/app_bar.dart';
import 'package:crud_app/screens/admin/q&a_forum/add_question_form.dart';
import 'package:flutter/material.dart';
class AddQuestionScreen extends StatelessWidget {

  final FocusNode _descriptionFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        _descriptionFocusNode.unfocus();

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 29, 177, 152),
          title: const AppBarTitle(
            sectionName: "Add Category",

          ),
        ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20),
              child: AddWithImage(
                  descriptionFocusNode: _descriptionFocusNode,
              ),
            )),
      ),
    );
  }
}