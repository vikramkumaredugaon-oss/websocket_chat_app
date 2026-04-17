import '../../../core/base/base_viewmodel.dart';

class DashboardViewModel extends BaseViewModel {
  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    notifyListeners();
  }
}