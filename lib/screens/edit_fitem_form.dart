// ignore_for_file: empty_constructor_bodies

import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final String currentTitle;
  final String  currentImageURL;
  final String currrentDescription;
  final String documentId;

  const EditItemForm(
      {required this.titleFocusNode,
      required this.descriptionFocusNode,
      required this.currrentDescription,
      required this.currentImageURL,
      required this.currentTitle,
      required this.documentId});

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _addItemForKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String updateTitle = "";
  String updateDescription = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addItemForKey,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.0),
                Text('Title',
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                CustomFormField(
                  initialValue: widget.currrentDescription,
                  isLabelEnabled: false,
                  controller: _titleController,
                  focusNode: widget.titleFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: "Title",
                  hint: "Write your title",
                  validator: (value) {
                    Validator.validateField(value: value);
                    updateTitle = value;
                  },
                ),
                SizedBox(height: 9.0),
                Text('description',
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                CustomFormField(
                  initialValue: widget.currrentDescription,
                  maxLines: 10,
                  isLabelEnabled: false,
                  controller: _descriptionController,
                  focusNode: widget.descriptionFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: "description",
                  hint: "Write your description",
                  validator: (value) {
                    Validator.validateField(value: value);
                    updateDescription = value;
                  },
                ),
              ],
            ),
          ),
          _isProcessing
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orangeAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();

                      if (_addItemForKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.updateFlowerItem(
                            docId: widget.documentId,
                            title: updateTitle,
                            imageURL: widget.currentImageURL,
                            description: updateDescription);

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
                        child: Text(
                          'Update data',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            letterSpacing: 2,
                          ),
                        )),
                  ))
        ]),
      ),
    );
  }
}
