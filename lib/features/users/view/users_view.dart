import 'package:flutter/material.dart';
import 'package:websocket_chat/core/theme/colors.dart';

import '../../../core/base/base_view.dart';
import '../../../core/base/view_state.dart';
import '../../../core/constants/app_strings.dart';
import '../../../widgets/loading_widget.dart';
import '../viewmodel/users_viewmodel.dart';
import '../model/user_list_model.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<UsersViewModel>(
      viewModel: UsersViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.newChat),
            actions: [
              PopupMenuButton(itemBuilder: (context) => [
                PopupMenuItem(onTap: vm.state == ViewState.loading ? null : vm.fetchUsers,child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.refresh,color: AppColors.background,),),
                    Text("Refresh",style: TextStyle(color: AppColors.background),)
                  ],
                ),
                )
              ],color: AppColors.primary,)
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search users...",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty ? IconButton(onPressed: (){
                      searchController.clear();
                      vm.clearSearch();
                    }, icon: Icon(Icons.close)) : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: vm.searchUsers,
                ),
              ),
            ),
          ),

          // 🔒 GAME CHANGER — blocks all taps during loading
          body: AbsorbPointer(
            absorbing: vm.state == ViewState.loading,
            child: _buildBody(context, vm),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, UsersViewModel vm) {
    if (vm.state == ViewState.loading) {
      return const LoadingWidget();
    }

    if (vm.users.isEmpty) {
      return const Center(
        child: Text(AppStrings.noDataFound),
      );
    }

    return ListView.separated(
      itemCount: vm.users.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final user = vm.users[index];

        return _UserTile(
          user: user,
          onTap: () async {
            final conversationId = await vm.startChat(user);

            if (conversationId == null) return;

            if (context.mounted) {
              await Navigator.pushNamed(
                context,
                "/chat",
                arguments: {
                  "conversationId": conversationId,
                  "otherUserId": user.id,
                  "otherUserName": user.name,
                  "isOnline": user.isOnline,
                  "lastSeen": user.lastSeen,
                },
              );

              vm.unlockNavigation();
            }
          },
        );
      },
    );
  }
}

class _UserTile extends StatelessWidget {
  final UserListModel user;
  final VoidCallback onTap;

  const _UserTile({
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            child: Text(
              user.name.isNotEmpty
                  ? user.name[0].toUpperCase()
                  : "?",
            ),
          ),

            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: user.isOnline ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}

class _OnlineDot extends StatelessWidget {
  final bool isOnline;

  const _OnlineDot({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}