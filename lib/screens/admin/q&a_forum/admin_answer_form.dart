import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/custom_form_field.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';

class EditItemForm extends StatefulWidget {
  final String documentId;
  final String currentDescription;
  final String currentImageURL;
  final String currentAnswer;
  final FocusNode descriptionFocusNode;
  final FocusNode answerFocusNode;

  // ignore: use_key_in_widget_constructors
  const EditItemForm({
    required this.documentId,
    required this.currentDescription,
    required this.currentImageURL,
    required this.descriptionFocusNode,
    required this.currentAnswer,
    required this.answerFocusNode,
  });

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _descriptionContoller = TextEditingController();
  final TextEditingController _answerContoller = TextEditingController();

  String updateDescription = "";
  String updateURL = "";
  String updateAnswer = "";

  @override
  Widget build(BuildContext context) {
          return SingleChildScrollView(
            child: Form(
                key: _addItemFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 24),
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
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0,),
                            child: Text(
                              widget.currentDescription,
                              maxLines: 8,
                              style:
                              TextStyle(color: Colors.black.withOpacity(0.6),
                                  fontSize: 18),
                            ),
                          ),

                          CachedNetworkImage(
                            imageUrl: widget.currentImageURL,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                              maxLines: 3,
                              isLabelEnabled: false,
                              controller: _answerContoller,
                              focusNode: widget.answerFocusNode,
                              keyboardType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              label: "Answer",
                              hint: "Write the Answer",
                              validator: (value) {
                                Validator.validateField(
                                  value: value,
                                );
                                updateAnswer = value;
                              }),

                        ],
                      ),
                    ),
                    _isProcessing
                        ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 29, 177, 152)),
                      ),

                    )
                        : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(
                                Color.fromARGB(255, 14, 204, 172)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        onPressed: () async {
                          widget.descriptionFocusNode.unfocus();

                          if (_addItemFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });


                            await Database.answerQuestion(
                                docId: widget.documentId,
                                imageURL: widget.currentImageURL,
                                description: widget.currentDescription,
                                answer: updateAnswer);

                            setState(() {
                              _isProcessing = false;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            'Answer the Question',
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