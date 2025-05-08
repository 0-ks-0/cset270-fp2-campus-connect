import "package:flutter/material.dart";

class MyTextField extends StatelessWidget
{
  final TextEditingController? controller;
  final FormFieldValidator<String> validator;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const MyTextField({
    super.key,
    required this.validator,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      validator: validator,

      controller: controller,

      obscureText: obscureText,

      decoration: InputDecoration(
        border:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(100),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(100),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(100),
        ),

        fillColor: Colors.grey.shade200,
        filled: true,

        contentPadding: EdgeInsets.symmetric(horizontal: 20),

        hintText:hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),

        suffixIcon: suffixIcon,
      ),
    );
  }
}
