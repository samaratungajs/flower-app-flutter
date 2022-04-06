import 'dart:io';
import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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
  static String imageURL = "";

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
                  padding: EdgeInsets.all(6),
                  child: Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox.fromSize(
                          size: Size.fromRadius(88),
                          child: _image == null
                              ? Image.network(
                                  "https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg",
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
                              size: 25, color: Color.fromARGB(255, 99, 99, 99)),
                          onPressed: () {
                            getImage(context);
                          },
                        ),
                      ),
                    )
                  ]),
                ),
                const Text('Flower Name',
                    style: TextStyle(
                        color: Color.fromARGB(255, 9, 75, 103),
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
                  label: "Flower Name",
                  hint: "Write your flower name",
                  validator: (value) {
                    Validator.validateField(value: value);
                    getTitle = value;
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
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 9, 75, 103)),
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

                        await ref.putFile(File(pickedImage!.path));
                        imageURL = await ref.getDownloadURL();

                        await Database.addFlowerItem(
                            title: getTitle,
                            description: getDescription,
                            imageURL: imageURL);

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
