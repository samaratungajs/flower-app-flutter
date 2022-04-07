import 'dart:convert';
import 'package:crud_app/screens/admin/admin_dashboard.dart';
import 'package:crud_app/screens/admin/category/admin_home.dart';
import 'package:crud_app/screens/client/client_dashboard.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/custom_form_field.dart';

class LoginForm extends StatefulWidget {
  final FocusNode focusNode;
  const LoginForm({Key? key, required this.focusNode}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _uidController = TextEditingController();

  final _logInFormKey = GlobalKey<FormState>();
  String getUserId = "";

// Show Alert box
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Invalid User ID"),
      content: Text("Please input a valid user ID !"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _logInFormKey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24.0),
              child: Column(
                children: [
                  CustomFormField(
                      initialValue: "",
                      isObscure: true,
                      controller: _uidController,
                      focusNode: widget.focusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      label: "Unique user ID",
                      hint: "Enter your unique identifier",
                      validator: (value) {
                        Validator.validateUserId(
                          uid: value,
                        );
                        getUserId = value;
                      })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 29, 177, 152)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                  ),
                  onPressed: () {
                    widget.focusNode.unfocus();

                    if (_logInFormKey.currentState!.validate()) {
                      Database.userId = getUserId;
                      if (getUserId == "admin") {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Admindahboard(),
                          ),
                        );
                      }
                      else if (getUserId == "client") {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ClientDashboard(),
                          ),
                        );
                      } 
                      else {
                        showAlertDialog(context);
                        
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
