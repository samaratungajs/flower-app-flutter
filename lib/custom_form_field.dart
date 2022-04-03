import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputType keyboardType,
    required TextInputAction inputAction,
    required String label,
    required String initialValue,
    required String hint,
    required Function(String value) validator,
    this.isObscure = false,
    this.isCapitalized = false,
    this.maxLines = 1,
    this.isLabelEnabled = true,
  })  : _keyboardType = keyboardType,
        _inputAction = inputAction,
        _label = label,
        _initialValue = initialValue,
        _hint = hint,
        _validator = validator,
        super(key: key);

  final TextInputType _keyboardType;
  final TextInputAction _inputAction;
  final String _label;
  final String _hint;
  final String _initialValue;
  final bool isObscure;
  final bool isCapitalized;
  final int maxLines;
  final bool isLabelEnabled;
  final Function(String) _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.grey),
      initialValue: _initialValue,
      maxLines: maxLines,
      keyboardType: _keyboardType,
      obscureText: isObscure,
      textCapitalization:
          isCapitalized ? TextCapitalization.words : TextCapitalization.none,
      textInputAction: _inputAction,
      cursorColor: Colors.blue,
      validator: (value) => _validator(value!),
      decoration: InputDecoration(
        labelText: isLabelEnabled ? _label : null,
        labelStyle: TextStyle(color: Colors.pink),
        hintText: _hint,
        hintStyle: TextStyle(color: Colors.amber),
        errorStyle: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.green, width: 2)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 211, 1, 1), width: 2)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 255, 8, 243), width: 2),
        ),
      ),
    );
  }
}
