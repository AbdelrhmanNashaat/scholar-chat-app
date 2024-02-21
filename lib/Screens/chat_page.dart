import 'package:flutter/material.dart';
import 'package:scholar_chat/Models/message.dart';

import 'package:scholar_chat/Widgets/constants.dart';
import 'package:scholar_chat/cubit/chat_cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/chat_buble.dart';

class ChatPage extends StatelessWidget {
  List<Message> messageList = [];
  ChatPage({Key? key}) : super(key: key);
  static String id = 'chat page';
  TextEditingController controller = TextEditingController();
  final controllerList = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 60,
            ),
            const Text('Scholar chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messageList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: controllerList,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? chatBuble(
                            message: messageList[index],
                          )
                        : chatBubleForFreind(
                            message: messageList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email.toString());
                controller.clear();
                controllerList.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
