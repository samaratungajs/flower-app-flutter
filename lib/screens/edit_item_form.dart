import 'package:flutter/material.dart';

import '../custom_form_field.dart';
import '../validators/database.dart';
import '../validators/validator.dart';

class EditItemForm extends StatefulWidget {
  final String documentId;
  final String currentTitle;
  final String currentDescription;
  final String currentOrigin;
  final String currentImageURL;
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode originFocusNode;

  const EditItemForm({
    required this.documentId,
    required this.currentTitle,
    required this.currentDescription,
    required this.currentImageURL,
    required this.currentOrigin,
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.originFocusNode,
  });

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionContoller = TextEditingController();
  final TextEditingController _originContoller = TextEditingController();

  String updateTitle = "";
  String updateDescription = "";
  String updateOrigin = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _addItemFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      'Categry',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 177, 152),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                      initialValue: widget.currentTitle,
                        isLabelEnabled: false,
                        controller: _titleController,
                        focusNode: widget.titleFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Category",
                        hint: "Write category Name",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateTitle = value;
                        }),
                    const SizedBox(height: 24.0),

                    const Text(
                      'Origin',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 177, 152),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                      initialValue: widget.currentOrigin,
                        isLabelEnabled: false,
                        controller: _originContoller,
                        focusNode: widget.titleFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Origin",
                        hint: "Write origins",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateOrigin = value;
                        }),

                    const SizedBox(height: 24.0),
                    const Text(
                      'Description',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 177, 152),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                        initialValue: widget.currentDescription,
                        maxLines: 10,
                        isLabelEnabled: false,
                        controller: _descriptionContoller,
                        focusNode: widget.descriptionFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Description",
                        hint: "Write Description",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateDescription = value;
                        }),
                  ],
                ),
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 29, 177, 152)),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color.fromARGB(255, 14, 204, 172)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        onPressed: () async {
                          widget.titleFocusNode.unfocus();
                          widget.descriptionFocusNode.unfocus();
    
                          if (_addItemFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });
                            await Database.updatedItem(
                                docId: widget.documentId,
                                title: updateTitle,
                                origin: updateOrigin,
                              imageURL: widget.currentImageURL,
                                description: updateDescription);
    
                            setState(() {
                              _isProcessing = false;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            'Update Data',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}
