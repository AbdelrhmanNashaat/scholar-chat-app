import 'package:flutter/material.dart';
import 'package:scholar_chat/Models/message.dart';

import 'constants.dart';

class chatBuble extends StatelessWidget {
  const chatBuble({required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 18,
          top: 26,
          bottom: 26,
          right: 18,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class chatBubleForFreind extends StatelessWidget {
  const chatBubleForFreind({required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          left: 18,
          top: 26,
          bottom: 26,
          right: 18,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
