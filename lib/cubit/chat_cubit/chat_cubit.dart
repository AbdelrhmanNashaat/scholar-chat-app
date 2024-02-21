import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../Models/message.dart';
import '../../Widgets/constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessage);

  void sendMessage({required String message, required String email}) {
    try{
      messages.add({kMessage: message, kCreatedAT: DateTime.now(), 'id': email});
    }
    catch(e){
      print(e);
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAT, descending: true).snapshots().listen((event) {
      List<Message> messageList = [];
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
