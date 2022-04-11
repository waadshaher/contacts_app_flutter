import 'package:flutter/material.dart';
import 'constants.dart';

class MyTextFormField extends StatelessWidget {
  final Function savedValues;
  final String myHintText;
  final String myLabelText;
  final bool isName;
  const MyTextFormField(
      {Key? key,
      required this.savedValues,
      required this.isName,
      required this.myHintText,
      required this.myLabelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green.shade400,
          fontWeight: FontWeight.bold,
        ),
        validator: (value) =>
            isName ? validationMethod(value) : _validationMethodPhone(value),
        onSaved: (value) {
          savedValues(value);
        },
        cursorColor: Colors.blue,
        decoration: myDecorator(myLabelText, hint: myHintText));
  }

  validationMethod(String? value) {
    if (value == null || value.isEmpty) {
      return 'This is a required field';
    }
    return null;
  }

  _validationMethodPhone(String? value) {
    String pattern = r'^(\+?6?01)[0-46-9]-*[0-9]{7,8}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'This is a required field';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
