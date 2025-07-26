import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildField {
  static Widget buildTextFormField(
    String labelText, {
    List<TextInputFormatter>? inputFormatters,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      obscureText: true,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        filled: true,
        fillColor: Colors.white60,
      ),
      style: const TextStyle(color: Colors.black),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
