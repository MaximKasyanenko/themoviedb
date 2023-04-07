import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  const MyTextFieldWidget(
      {super.key, this.obscureText = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.blue,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: const InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
