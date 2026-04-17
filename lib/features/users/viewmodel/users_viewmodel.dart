import '../../../core/base/base_viewmodel.dart';
import '../../../core/utils/logger.dart';
import '../model/user_list_model.dart';
import '../service/user_service.dart';

class UsersViewModel extends BaseViewModel {
  List<UserListModel> users = [];
  List<UserListModel> _allUsers = [];
  String searchQuery = "";
  bool _isCreatingConversation = false;
  bool _hasNavigated = false;

  /// Init called from BaseView
  Future<void> init() async {
    await fetchUsers();
  }

  /// 👥 Load users
  Future<void> fetchUsers() async {
    try {
      setLoading();
      final data = await UsersService.getUsers();
      _allUsers = data;
      users = data;
      AppLogger.info("Users loaded: ${users.length}", tag: "USERS_VM");
      setIdle();
    } catch (e) {
      setError("Failed to load users");
    }
  }

  void searchUsers(String query) {
    searchQuery = query;

    if (query.isEmpty) {
      users = List.from(_allUsers);
    } else {
      final q = query.toLowerCase();

      users = _allUsers.where((user) {
        return user.name.toLowerCase().contains(q) ||
            user.email.toLowerCase().contains(q);
      }).toList();
    }

    notifyListeners();
  }

  void clearSearch() {
    searchQuery = "";
    users = List.from(_allUsers);
    notifyListeners();
  }

  /// 💬 Start chat (returns conversationId)

  bool _navigationLocked = false;

  Future<int?> startChat(UserListModel user) async {
    if (_isCreatingConversation || _navigationLocked) return null;

    try {
      _isCreatingConversation = true;

      final id =
      await UsersService.createOneToOneConversation(user.id);

      _navigationLocked = true;
      return id;
    } finally {
      _isCreatingConversation = false;
    }
  }

  void unlockNavigation() {
    _navigationLocked = false;
  }

}