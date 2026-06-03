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
  final ValueNotifier<bool> showFullDate = ValueNotifier(true);
  @override
  void initState() {
    super.initState();

    if (!widget.isOnline) {
      Future.delayed(Duration(seconds: 3), () {
        showFullDate.value = false;
      });
    }
  }

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
            titleSpacing: 0,
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CallingPage(callID: vm.callID, userID: vm.userID, userName: vm.userName, isVideoCall: true,),));
              }, icon: Icon(Icons.videocam),),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CallingPage(callID: vm.callID, userID: vm.userID, userName: vm.userName, isVideoCall: false,),));
              }, icon: Icon(Icons.call)),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
            ],
            title: Row(
              children: [
                CircleAvatar(
                  child: Text(widget.otherUserName[0]),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.otherUserName,
                        style: const TextStyle(fontSize: 16),
                      ),

                      ValueListenableBuilder<bool>(
                        valueListenable: showFullDate,
                        builder: (context, value, child) {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            child: Text(
                              widget.isOnline
                                  ? "Online"
                                  : value
                                  ? "Last seen ${DateUtilsHelper.lastSeenDate(widget.lastSeen!)}"
                                  : "${DateUtilsHelper.lastSeenTime(widget.lastSeen!)}",
                              key: ValueKey(value),
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.isOnline ? Colors.green : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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
                  suffixIcon: Icon(Icons.camera_alt_outlined),
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

 
/// ajay.kumar@edugaon.com