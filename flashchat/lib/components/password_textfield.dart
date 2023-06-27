import 'package:flutter/material.dart';

import '../constants.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: kTextFieldDecoration.copyWith(
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
