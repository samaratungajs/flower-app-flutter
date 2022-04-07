import 'dart:io';
import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddQuizForm extends StatefulWidget {
  // final FocusNode titleFocusNode;
  final FocusNode questionFocusNode;
  final FocusNode answerFocusNode;
  final FocusNode wrongAnswerFocusNode;
  final FocusNode descriptionFocusNode;

  const AddQuizForm({
    // required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.questionFocusNode,
    required this.wrongAnswerFocusNode,
    required this.answerFocusNode,
  });

  @override
  State<AddQuizForm> createState() => _AddQuizFormState();
}

class _AddQuizFormState extends State<AddQuizForm> {
  final _addQuizFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  // final TextEditingController _titleController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _wrongAnswerController = TextEditingController();
  final TextEditingController _descriptionContoller = TextEditingController();

  // String getTitle = "";
  String getDescription = "";
  String getQuestion = "";
  String getAnswer = "";
  String getWrongAnswer = "";
  static String imageURL = "";

  static var pickedImage;
  File? _image;

  //upload image
  final picker = ImagePicker();
  Reference ref = FirebaseStorage.instance
      .ref()
      .child("category" + DateTime.now().toString());

  Future getImage() async {
    pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _addQuizFormKey,
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
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.all(6), // Border width
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 29, 177, 152),
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(88), // Image radius
                                child: _image == null
                                    ? Image.network(
                                        "https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg",
                                        fit: BoxFit.cover)
                                    : Image.file(_image!)),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_sharp,
                          size: 35,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                    const Text(
                      'Question',
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
                        initialValue: "",
                        isLabelEnabled: false,
                        controller: _questionController,
                        focusNode: widget.questionFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Question",
                        hint: "Enter the question",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          getQuestion = value;
                        }),
                        //new
                        const Text(
                      'Answer',
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
                        initialValue: "",
                        isLabelEnabled: false,
                        controller: _answerController,
                        focusNode: widget.answerFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Answer",
                        hint: "Enter the Answer",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          getAnswer = value;
                        }),
                        const Text(
                      'Wrong Answer',
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
                        initialValue: "",
                        isLabelEnabled: false,
                        controller: _wrongAnswerController,
                        focusNode: widget.wrongAnswerFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "wrongAnswer",
                        hint: "Enter the Answer",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          getWrongAnswer = value;
                        }),
    
                        //old
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
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 29, 177, 152)),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 14, 204, 172)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        onPressed: () async {
                          widget.questionFocusNode.unfocus();
                          widget.answerFocusNode.unfocus();
                          widget.wrongAnswerFocusNode.unfocus();
                          widget.descriptionFocusNode.unfocus();

                          if (_addQuizFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });
                            await ref.putFile(File(pickedImage!.path));
                            imageURL = await ref.getDownloadURL();

                            print(imageURL);
                            await Database.addQuestion(
                                question: getQuestion,
                                answer: getAnswer,
                                wrongAnswer: getWrongAnswer,
                                description: getDescription,
                                imageURL: imageURL);

                            setState(() {
                              _isProcessing = false;
                              pickedImage = null;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            'Add Data',
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
