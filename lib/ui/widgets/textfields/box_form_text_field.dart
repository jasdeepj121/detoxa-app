import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<TextInputFormatter> formatters = [FilteringTextInputFormatter.allow("")];

class BoxTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final String hintText;
  final Function(String) validator;
  final List<TextInputFormatter> inputFormatters;
  final bool obscureText;
  final Widget suffixIcon;
  final TextInputType keyboardType;

  const BoxTextFormField({
    Key key,
    this.controller,
    this.hintText,
    this.maxLength,
    this.validator,
    this.inputFormatters,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          // borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        isDense: true,
        counterText: "",
        contentPadding: const EdgeInsets.all(14),
        suffixIcon: suffixIcon,
      ),
      inputFormatters: inputFormatters ?? [],
      validator: validator,
      obscureText: obscureText ?? false,
    );
  }
}
