import 'package:flutter/material.dart';

import '../custom_form_field.dart';
import '../validators/database.dart';
import '../validators/validator.dart';

class EditQuizForm extends StatefulWidget {
  final String documentId;
  final String currentQuestion;
  final String currentAnswer;
  final String currentWrongAnswer;
  final String currentDescription;
  final FocusNode answerFocusNode;
  final FocusNode questionFocusNode;
  final FocusNode wrongAnswerFocusNode;
  final FocusNode descriptionFocusNode;

  const EditQuizForm({
    required this.documentId,
    required this.currentAnswer,
    required this.currentDescription,
    required this.answerFocusNode,
    required this.currentWrongAnswer,
    required this.currentQuestion,
    required this.descriptionFocusNode,
    required this.wrongAnswerFocusNode,
    required this.questionFocusNode,
  });

  @override
  State<EditQuizForm> createState() => _EditQuizFormState();
}

class _EditQuizFormState extends State<EditQuizForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _wrongAnswerController = TextEditingController();
  final TextEditingController _descriptionContoller = TextEditingController();

  String updateAnswer = "";
  String updateQuestion = "";
  String updateWrongAnswer = "";
  String updateDescription = "";

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
                      initialValue: widget.currentQuestion,
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
                          updateQuestion = value;
                        }),
                    const SizedBox(
                      height: 24.0,
                    ),
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
                      initialValue: widget.currentAnswer,
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
                          updateAnswer = value;
                        }),
                    const SizedBox(
                      height: 24.0,
                    ),
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
                      initialValue: widget.currentWrongAnswer,
                        isLabelEnabled: false,
                        controller: _wrongAnswerController,
                        focusNode: widget.wrongAnswerFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "WrongAnswer",
                        hint: "Enter the Answer",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateWrongAnswer = value;
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
                        hint: "Write your Description",
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
                          widget.answerFocusNode.unfocus();
                          widget.descriptionFocusNode.unfocus();
                          widget.questionFocusNode.unfocus();
                          widget.wrongAnswerFocusNode.unfocus();

                          if (_addItemFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });
                            await Database.updateQuestion(
                                docId: widget.documentId,
                                question : updateQuestion,
                                answer: updateAnswer,
                                wrongAnswer: updateWrongAnswer,
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
