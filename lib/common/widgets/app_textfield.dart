import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String> validator;
  final TextInputType keyboard;
  final bool isPassword;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.validator,
    this.keyboard = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);
  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = widget.controller;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
          child: TextFormField(
            controller: controller,
            validator: widget.validator,
            keyboardType: widget.keyboard,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              labelText: widget.hint,
              hintText: widget.hint,
            ),
          ),
        ),
      ],
    );
  }
}
