import 'package:flutter/material.dart';

class EcoTextField extends StatefulWidget {
  String? hintText;
  bool isPassword;
  Widget? icon;
  bool check;
  int? maxLines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  TextEditingController? controller;
  String? Function(String?)? validate;
  EcoTextField(
      {this.hintText,
      this.controller,
      this.validate,
      this.maxLines,
      this.isPassword = false,
      this.icon,
      this.check = false,
      this.inputAction,
      this.focusNode});

  @override
  State<EcoTextField> createState() => _EcoTextFieldState();
}

class _EcoTextFieldState extends State<EcoTextField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        // maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        textInputAction: widget.inputAction,
        focusNode: widget.focusNode,
        controller: widget.controller,
        validator: widget.validate,
        obscureText: widget.isPassword == false ? false : widget.isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText ?? 'Hint text..',
          // suffixIcon: isPassword==true? Icon(Icons.visibility): Icon(Icons.email),
          suffixIcon: widget.icon,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
