import 'package:crud_app/screens/app_bar.dart';
import 'package:crud_app/screens/edit_item_form.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String currentTitle;
  final String currrentDescription;
  final String documentId;

  const EditScreen({
    required this.currentTitle,
    required this.currrentDescription,
    required this.documentId,
  });

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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          elevation: 2,
          toolbarHeight: 150,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          title: const AppBarTitle(
            sectionName: "Update Category",
          ),
          actions: [
            _isDeleting
                ? SizedBox(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 6, 212, 178)),
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
                    )
                    )
          ],
        ),

        body: SafeArea(child: Padding(padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 20.0
        ),
        child: EditItemForm(
          documentId: widget.documentId,
          titleFocusNode: _titleFocusNode,
          descriptionFocusNode: _descriptionFocusNode,
          currentTitle:widget.currentTitle,
          currentDescription : widget.currrentDescription
        ),
        )
        ),
      ),
    );
  }
}
