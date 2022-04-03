import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';

class AddItemFormm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const AddItemFormm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  State<AddItemFormm> createState() => _AddItemFormmState();
}

class _AddItemFormmState extends State<AddItemFormm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionContoller = TextEditingController();

  String getTitle = "";
  String getDescription = "";

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
                      'Title',
                      style: TextStyle(
                          color: Color.fromARGB(255, 40, 67, 88),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                        initialValue: "",
                        isLabelEnabled: false,
                        controller: _titleController,
                        focusNode: widget.titleFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Title",
                        hint: "Write your title",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          getTitle = value;
                        }),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Title',
                      style: TextStyle(
                          color: Color.fromARGB(255, 40, 67, 88),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                        initialValue: "",
                        maxLines: 10,
                        isLabelEnabled: false,
                        controller: _descriptionContoller,
                        focusNode: widget.descriptionFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Description",
                        hint: "Write your Description",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          getDescription = value;
                        }),
                  ],
                ),
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orangeAccent),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () async {
                          widget.titleFocusNode.unfocus();
                          widget.descriptionFocusNode.unfocus();

                          if (_addItemFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });
                            await Database.addItem(
                                title: getTitle, description: getDescription);

                            setState(() {
                              _isProcessing = false;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            'Add Data',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
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
