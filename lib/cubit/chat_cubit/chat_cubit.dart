import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../const/const.dart';
import '../../models/messageModel.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference message = FirebaseFirestore.instance.collection(kMessagesCollection);

  void sendMessage({required String messages , required var Email}){
    message.add({
      kMessage: messages,
      kCreatedAt: DateTime.now(),
      "id": Email
    });
  }

  void getMessage(){
    message.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = [];
      for (var doc in event.docs ){
        messageList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(message:messageList));
    });
  }
}
