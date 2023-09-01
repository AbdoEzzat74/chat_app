import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatPage extends StatelessWidget {

    ChatPage({super.key});
  Duration duration = const Duration();

  final now = DateTime.now();

  final ScrollController _scrollController = ScrollController();

  List<MessageModel> messageList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/scholar.png", width: 50),
            const Text("Chat")
          ],
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if(state is ChatSuccess){
                  messageList = state.message;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        messageList[index].id == email
                            ? BubbleNormal(
                          text: messageList[index].messageModel,
                          isSender: false,
                          color: const Color(0xFF1B97F3),
                          tail: true,
                          seen: true,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                            : BubbleNormal(
                          text: messageList[index].messageModel,
                          isSender: true,
                          color: const Color(0xFFE8E8EE),
                          tail: true,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          MessageBar(
            onSend: (data) {
              BlocProvider.of<ChatCubit>(context).sendMessage(
                  messages: data,
                  Email: email,
              );
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 50),
                curve: Curves.easeIn,
              );
            },
            actions: [
              InkWell(
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {

                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

