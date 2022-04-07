import 'package:crud_app/screens/admin/category/app_bar.dart';
import 'package:crud_app/screens/admin/flowers/add_fitem_form.dart';
import 'package:flutter/material.dart';

class AddFScreen extends StatelessWidget {
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
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 29, 177, 152),
            title: const AppBarTitle(
              sectionName: 'Crud',
            ),
          ),
          body: SafeArea(
            child: Padding(
              // ignore: prefer_const_constructors
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: AddFItemForm(
                titleFocusNode: _titleFocusNode,
                descriptionFocusNode: _descriptionFocusNode,
              ),
            ),
          )),
    );
  }
}
