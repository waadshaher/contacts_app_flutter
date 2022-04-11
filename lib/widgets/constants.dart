import 'package:flutter/material.dart';

myDecorator(String label, {String hint = ""}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    labelStyle:
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontStyle: FontStyle.italic,
    ),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlue),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlue),
    ),
  );
}
