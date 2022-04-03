import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';

class AddFItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  const AddFItemForm(
      {required this.titleFocusNode, required this.descriptionFocusNode});

  @override
  State<AddFItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddFItemForm> {
  final _addItemForKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String getTitle = "";
  String getDescription = "";

  @override
  Widget build(BuildContext context) {
    return Form(
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
                initialValue: "",
                isLabelEnabled: false,
                controller: _titleController,
                focusNode: widget.titleFocusNode,
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
                label: "Title",
                hint: "Write your title",
                validator: (value) {
                  Validator.validateField(value: value);
                  getTitle = value;
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
                initialValue: "",
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
                  getDescription = value;
                },
              ),
            ],
          ),
        ),
        _isProcessing
            ? const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
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

                      await Database.addFlowerItem(
                          title: getTitle, description: getDescription);

                      setState(() {
                        _isProcessing = false;
                      });

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
                      child: Text(
                        'Add data',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          letterSpacing: 2,
                        ),
                      )),
                ))
      ]),
    );
  }
}
