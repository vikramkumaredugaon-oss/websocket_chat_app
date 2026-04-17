import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:websocket_chat/core/theme/colors.dart';
import 'package:websocket_chat/features/videocall/view/calling_page.dart';

import '../../../core/base/base_view.dart';
import '../../../core/base/view_state.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_utils.dart';
import '../../../widgets/app_textfield.dart';
import '../../../widgets/chat_bubble.dart';
import '../../../widgets/loading_widget.dart';
import '../viewmodel/chat_viewmodel.dart';

class ChatView extends StatefulWidget {
  final int conversationId;
  final int myUserId;
  final int otherUserId;
  final String otherUserName;
  final bool isOnline;
  final String? lastSeen;

  const ChatView({
    super.key,
    required this.conversationId,
    required this.myUserId,
    required this.otherUserId,
    required this.otherUserName,
    required this.isOnline,
    this.lastSeen,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatViewModel>(
      viewModel: ChatViewModel(
        conversationId: widget.conversationId,
        myUserId: widget.myUserId,
        otherUserId: widget.otherUserId,
      ),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context) {
                  return AlertDialog(backgroundColor: Colors.white, shape: RoundedRectangleBorder(),
                    insetPadding: EdgeInsets.all(0),
                    title: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(Icons.videocam, color: Colors.blue, size: 30),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Start Video Call",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Enter User ID to start call",
                          style: TextStyle(color: Colors.black,fontSize: 18),
                        ),
                        SizedBox(height: 15),
                        AppTextField(
                          controller: _textController,
                          hintText: "Please Required ID*",
                          prefixIcon: Icon(Icons.person),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: MaterialButton(onPressed: (){
                                  Navigator.pop(context);
                                },height: 45,minWidth: 120,shape: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff2c5364))),child: Text("Cancel",style: TextStyle(color: Colors.black),),
                                ),
                              ),

                              MaterialButton(onPressed: (){
                                String callId = _textController.text.trim();

                                if (callId.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please enter User ID"),
                                    ),
                                  );
                                  return;
                                }
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CallingPage(callID: _textController.text),));
                              },height: 45,minWidth: 120,color: Color(0xff2c5364),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),child: Row(
                                children: [
                                  Icon(Icons.videocam,color: Colors.white,),
                                  SizedBox(width: 15,),
                                  Text("Join",style: TextStyle(color: Colors.white),),
                                ],
                              ),
                              ),
                          ],
                        )
                      ],
                    ),
                  );
                },);
              },
                icon: Icon(Icons.videocam),)
            ],
            title: Row(
              children: [
                CircleAvatar(
                  child: Text(widget.otherUserName[0]),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.otherUserName,
                      style: const TextStyle(fontSize: 16),
                    ),

                    Text(
                      widget.isOnline
                          ? "Online"
                          : "Last seen ${DateUtilsHelper.lastSeen(widget.lastSeen!)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.isOnline ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              // 💬 Messages list
              Expanded(
                child: _buildMessages(vm),
              ),

              // ✍️ Input bar
              _buildInputBar(vm),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessages(ChatViewModel vm) {
    if (vm.state == ViewState.loading) {
      return const LoadingWidget();
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels ==
            scroll.metrics.minScrollExtent) {
          vm.loadMore();
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        padding: const EdgeInsets.all(8),
        itemCount: vm.messages.length,
        itemBuilder: (context, index) {
          final msg = vm.messages[vm.messages.length - 1 - index];

          return ChatBubble(
            message: msg.message,
            createdAt: msg.createdAt,
            isMe: msg.senderId == widget.myUserId,
            isSeen: msg.seen,
            isDelivered: msg.delivered,
          );
        },
      ),
    );
  }

  Widget _buildInputBar(ChatViewModel vm) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _messageController,
                  hintText: AppStrings.typeMessage,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(radius: 22,backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send,color: AppColors.background,size: 20,),
                    onPressed: () {
                      final text = _messageController.text.trim();
                      if (text.isEmpty) return;

                      vm.sendMessage(text);
                      _messageController.clear();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}