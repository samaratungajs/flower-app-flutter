import 'package:crud_app/screens/add_item_form.dart';
import 'package:crud_app/screens/app_bar.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 67, 88),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          title: const AppBarTitle(
            sectionName: "Add Ittem",
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20),
          child: AddItemFormm(
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode),
        )),
      ),
    );
  }
}
