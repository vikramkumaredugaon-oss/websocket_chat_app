import 'dart:math';

import 'package:flutter/material.dart';
import 'package:websocket_chat/features/videocall/constant/app_info.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
class CallingPage extends StatefulWidget {
  const CallingPage({super.key, required this.callID});
  final String callID;

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  final userId = Random().nextInt(10000);
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: AppInfo.appId,
        appSign: AppInfo.appSign,
        callID: widget.callID,
        userID: userId.toString(),
        userName: "user_name$userId",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
    );
  }
}
