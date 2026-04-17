import 'package:flutter/material.dart';
import 'package:websocket_chat/core/base/base_view.dart';
import 'package:websocket_chat/core/theme/colors.dart';
import 'package:websocket_chat/features/auth/viewmodel/auth_viewmodel.dart';
  class RecentChatView extends StatefulWidget {
    const RecentChatView({super.key});

  @override
      State<RecentChatView> createState() => _RecentChatViewState();
}

    class _RecentChatViewState extends State<RecentChatView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        viewModel: AuthViewModel(),
        onModelReady: (vm) => vm.init(),
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("ChatNova"),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.qr_code_scanner)),
                IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined)),
                PopupMenuButton(itemBuilder: (context) => [
                  PopupMenuItem(child: Row(children: [IconButton(onPressed: (){}, icon: Icon(Icons.account_circle,color: AppColors.textPrimary,)), Text("Profile"),],)),
                  PopupMenuItem(child: Row(children: [IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: AppColors.textPrimary,)), Text("Settings"),],)),
                  PopupMenuItem(child: Row(children: [IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: AppColors.textPrimary,)), Text("Logout"),],),),
                ],)
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search users...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("RecentChatView")
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){
              Navigator.pushNamed(context, '/users');
            },backgroundColor: AppColors.primary,child: Icon(Icons.add_box,color: AppColors.background,),),
          );
        },);
  }
}
