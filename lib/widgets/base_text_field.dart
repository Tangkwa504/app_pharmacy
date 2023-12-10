import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefixIcon;
  final bool isObscure;

  const BaseTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.isObscure = false,
  });

  @override
  _BaseTextFieldState createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.withOpacity(0.4),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isObscure,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          hintText: widget.hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
