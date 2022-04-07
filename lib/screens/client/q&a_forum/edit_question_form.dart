import 'dart:io';
import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/screens/client/DB_model/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditItemForm extends StatefulWidget {
  final String documentId;
  final String currentDescription;
  final String currentImageURL;
  final FocusNode descriptionFocusNode;

  const EditItemForm({
    required this.documentId,
    required this.currentDescription,
    required this.currentImageURL,
    required this.descriptionFocusNode,
  });

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _descriptionContoller = TextEditingController();

  String updateDescription = "";
  String updateURL = "";


  static var pickedImage;
  File? _image;

  //upload image
  final picker = ImagePicker();
  Reference ref = FirebaseStorage.instance
      .ref()
      .child("category" + DateTime.now().toString());

  Future getImage(BuildContext context) async {
    pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Image Uploaded")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No Image Uploaded")));

      }
    });
  }

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
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CircleAvatar(
                        backgroundColor:
                        Color.fromARGB(255, 216, 216, 216),
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt_rounded,
                              size: 25,
                              color: Color.fromARGB(255, 99, 99, 99)),
                          onPressed: () {
                            getImage(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _isProcessing
                  ? const Padding(
                padding: EdgeInsets.all(16.0),
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
                    widget.descriptionFocusNode.unfocus();

                    if (_addItemFormKey.currentState!.validate()) {
                      setState(() {
                        _isProcessing = true;
                      });



                      await Database.updatedForum(
                          docId: widget.documentId,
                          imageURL: widget.currentImageURL,
                          description: updateDescription);

                      setState(() {
                        _isProcessing = false;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Text(
                      'Update Question',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}