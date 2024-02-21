import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String? text;
  VoidCallback? onTab;

  Button({Key? key, required this.text, required this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child:  Text(
          text!,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
