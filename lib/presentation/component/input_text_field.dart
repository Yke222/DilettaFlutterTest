import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType inputType;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final String? errorMsg;
  final String Function(String?)? onChanged;
  final Widget? suffixIcon;
  const InputTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.inputType,
      this.obscureText = false,
      this.onTap,
      this.validator,
      this.errorMsg,
      this.onChanged,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: inputType,
      onTap: onTap,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        errorText: errorMsg,
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
