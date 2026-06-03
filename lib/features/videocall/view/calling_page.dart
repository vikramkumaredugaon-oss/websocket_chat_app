import 'package:flutter/material.dart';
import 'package:websocket_chat/features/videocall/constant/app_info.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallingPage extends StatelessWidget {
  final String callID;
  final String userID;
  final String userName;
  final bool isVideoCall;

  const CallingPage({
    super.key,
    required this.callID,
    required this.userID,
    required this.userName,
    required this.isVideoCall,
  });

  @override
  Widget build(BuildContext context) {

    final config = isVideoCall
        ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: AppInfo.appId,
        appSign: AppInfo.appSign,
        callID: callID,
        userID: userID,
        userName: userName,
        config: config,
      ),
    );
  }
}