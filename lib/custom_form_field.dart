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
        _initialValue=initialValue,
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
      style: TextStyle(color: Color.fromARGB(255, 34, 34, 34), fontWeight: FontWeight.w600),
      initialValue: _initialValue,
      maxLines: maxLines,
      keyboardType: _keyboardType,
      obscureText: isObscure,
      textCapitalization:
          isCapitalized ? TextCapitalization.words : TextCapitalization.none,
      textInputAction: _inputAction,
      cursorColor: Color.fromARGB(206, 11, 179, 137),
      validator: (value) => _validator(value!),
      decoration: InputDecoration(
        labelText: isLabelEnabled ? _label : null,
        labelStyle: TextStyle(color: Color.fromARGB(206, 11, 179, 137)),
        hintText: _hint,
        hintStyle: TextStyle(color: Color.fromARGB(206, 77, 77, 77)),
        errorStyle: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Color.fromARGB(255, 29, 177, 152), width: 2)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.0),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 223, 4, 4), width: 2)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:
              BorderSide(
                color: Color.fromARGB(255, 240, 0, 12), width: 2
                ),
        ),
      ),
    );
  }
}
