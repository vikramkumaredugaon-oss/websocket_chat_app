import 'package:flutter/material.dart';
import 'package:websocket_chat/features/dashboard/communities/view/communities_view.dart';
import '../../../core/base/base_view.dart';
import '../../../widgets/bottom_navigation_bar_main.dart';
import '../call/view/calls_view.dart';
import '../chat/view/recent_chat_view.dart';
import '../update/view/update_view.dart';
import '../viewmodel/dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      viewModel: DashboardViewModel(),
      builder: (context, vm, _) {

        return Scaffold(

          /// 📱 Screens
          body: IndexedStack(
            index: vm.currentIndex,
            children: const [
              RecentChatView(),
              UpdatesView(),
              CommunitiesView(),
              CallsView(),
            ],
          ),

          /// 🔻 Bottom Nav
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: vm.currentIndex,
            onTap: vm.changeTab,
          ),
        );
      },
    );
  }
}