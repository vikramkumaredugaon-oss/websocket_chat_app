import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_viewmodel.dart';

class OnboardingViewModel extends BaseViewModel {

  final PageController controller = PageController();

  bool lastPage = false;

  void onPageChanged(int index) {
    lastPage = index == 2;
    notifyListeners();
  }

  Future<void> onNext(BuildContext context) async {

    if (lastPage) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("onboarding_seen", true);

      if (!context.mounted) return;

      Navigator.pushReplacementNamed(context, "/login");

    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}