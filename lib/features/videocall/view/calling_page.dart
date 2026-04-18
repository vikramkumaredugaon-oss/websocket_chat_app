import 'dart:math';

import 'package:flutter/material.dart';
import 'package:websocket_chat/features/videocall/constant/app_info.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
class CallingPage extends StatefulWidget {
  final String callID;
  final String userID;
  final String userName;
  const CallingPage({super.key, required this.callID, required this.userID, required this.userName});

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: AppInfo.appId,
        appSign: AppInfo.appSign,
        callID: widget.callID,
        userID: widget.userID,
        userName: widget.userName,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
    );
  }
}
