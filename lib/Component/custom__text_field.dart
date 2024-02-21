import 'package:flutter/material.dart';

class CustomFormTextFieldWidget extends StatelessWidget {
  String? hint;
  Icon? icon;
  bool? obscureText;
  Function(String)? onChanged;
  CustomFormTextFieldWidget(
      {Key? key,
      required this.hint,
      required this.onChanged,
      this.icon,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data){
        if (data!.isEmpty) {
          return 'Felid IS Required';
        }
      },
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
