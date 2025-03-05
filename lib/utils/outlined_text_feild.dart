import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_size.dart';

class OutlinedTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  OutlinedTextField({
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.getHeight(5,context)),
      child: TextField(

        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(AppSize.getWidth(12,context)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getWidth(12,context)),
            borderSide: BorderSide(color: Colors.white, width: AppSize.getWidth(15,context)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: AppSize.getWidth(2,context)),
            borderRadius: BorderRadius.circular(AppSize.getWidth(12,context)),
          ),
        ),
      ),
    );
  }
}