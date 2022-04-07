// ignore_for_file: empty_constructor_bodies

import 'dart:io';

import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final String currentTitle;
  final String currentImageURL;
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
  static String imagURL = "";

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
            .showSnackBar(SnackBar(content: Text("Image Uploaded")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No Image Uploaded")));
      }
    });
  }

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
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6), // Border width
                  // decoration: BoxDecoration(
                  //     color: Color.fromARGB(255, 29, 177, 152),
                  //     borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      //crossAxisAlignment: center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                              size: Size.fromRadius(88), // Image radius
                              child: _image == null
                                  ? Image.network(widget.currentImageURL,
                                      fit: BoxFit.cover)
                                  : Image.file(_image!)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 216, 216, 216),
                            radius: 20,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_rounded,
                                  size: 25,
                                  color: Color.fromARGB(255, 99, 99, 99)),
                              onPressed: () {
                                getImage(context);
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
                Text('Flower Name',
                    style: TextStyle(
                        color: Color.fromARGB(255, 9, 75, 103),
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                CustomFormField(
                  initialValue: widget.currentTitle,
                  isLabelEnabled: false,
                  controller: _titleController,
                  focusNode: widget.titleFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  label: "Flower",
                  hint: "Write the Flower name",
                  validator: (value) {
                    Validator.validateField(value: value);
                    updateTitle = value;
                  },
                ),
                SizedBox(height: 9.0),
                Text('Description',
                    style: TextStyle(
                        color: Color.fromARGB(255, 9, 75, 103),
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
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 9, 75, 103)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();

                      if (_addItemForKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });
                        if (_image == null) {
                          imagURL = widget.currentImageURL;
                        } else {
                          await ref.putFile(File(pickedImage!.path));
                          imagURL = await ref.getDownloadURL();
                        }

                        await Database.updateFlowerItem(
                            docId: widget.documentId,
                            title: updateTitle,
                            imageURL: imagURL,
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
                            color: Colors.black,
                            letterSpacing: 2,
                          ),
                        )),
                  ))
        ]),
      ),
    );
  }
}
