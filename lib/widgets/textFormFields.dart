import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myTextField({required TextEditingController controller, Widget? prefixIcon, Widget? suffixIcon, required String? labelText, int? maxLines = 1, String? Function(String?)? validator, Null Function(dynamic value)? onSaved})
{
  return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget myTextField2({TextEditingController? controller, Widget? prefixIcon, Widget? suffixIcon, required String? labelText, int? maxLines = 1, String? Function(String?)? validator, required Null Function(dynamic value) onSaved})
{
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}