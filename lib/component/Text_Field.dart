import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget
{
  CustomFormTextField({this.validateText,this.hintText, this.onChanged , this.obscureText =false});
  Function(String)? onChanged;
  String? hintText;
  bool? obscureText;
  String? validateText ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return validateText;
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
