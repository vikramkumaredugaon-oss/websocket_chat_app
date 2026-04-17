import 'package:flutter/material.dart';
import '../core/constants/app_constant.dart';
import '../core/theme/colors.dart';
import '../core/utils/date_utils.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String createdAt; // ISO string
  final bool isMe;
  final bool isSeen;
  final bool isDelivered;

  const ChatBubble({
    super.key,
    required this.message,
    required this.createdAt,
    required this.isMe,
    this.isSeen = false,
    this.isDelivered = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.smallPadding,
          vertical: 4,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: 10,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.chatBubbleMe
              : AppColors.chatBubbleOther,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppConstants.borderRadius),
            topRight: const Radius.circular(AppConstants.borderRadius),
            bottomLeft: Radius.circular(
              isMe ? AppConstants.borderRadius : 0,
            ),
            bottomRight: Radius.circular(
              isMe ? 0 : AppConstants.borderRadius,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Message text
            Text(
              message,
              style: TextStyle(
                color: isMe
                    ? AppColors.chatTextMe
                    : AppColors.chatTextOther,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),

            // Time + ticks (for sent messages)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateUtilsHelper.formatChatTime(createdAt),
                  style: TextStyle(
                    color: isMe
                        ? Colors.white70
                        : AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 6),
                  Icon(
                    Icons.done_all,
                    size: 16,
                    color: isSeen
                        ? Colors.lightBlueAccent
                        : Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}