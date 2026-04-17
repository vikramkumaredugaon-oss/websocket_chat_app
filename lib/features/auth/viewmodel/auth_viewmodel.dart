import 'package:flutter/material.dart';
import '../../../core/base/base_viewmodel.dart';
import '../../../core/utils/logger.dart';
import '../../../core/constants/app_strings.dart';
import '../service/auth_service.dart';
import '../model/user_model.dart';

class AuthViewModel extends BaseViewModel {
  // 🧾 Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 📝 Fields
  String _email = "";
  String _password = "";
  String _name = "";

  UserModel? currentUser;

  /// Called from BaseView.onModelReady
  void init() {
    AppLogger.info("AuthViewModel initialized", tag: "AUTH_VM");
  }

  // 🔧 Setters (called from UI)
  void setEmail(String value) {
    _email = value.trim();
  }

  void setPassword(String value) {
    _password = value;
  }

  void setName(String value) {
    _name = value.trim();
  }

  // 🔐 LOGIN
  Future<bool> login() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      setLoading();

      currentUser = await AuthService.login(
        email: _email,
        password: _password,
      );

      AppLogger.info("Login successful", tag: "AUTH_VM");
      setIdle();
      return true;
    } catch (e) {
      setError(AppStrings.somethingWentWrong);
      return false;
    }
  }

  // 📝 REGISTER
  Future<bool> register() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      setLoading();

      currentUser = await AuthService.register(
        name: _name,
        email: _email,
        password: _password,
      );

      AppLogger.info("Registration successful", tag: "AUTH_VM");
      setIdle();
      return true;
    } catch (e) {
      setError(AppStrings.somethingWentWrong);
      return false;
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await AuthService.logout();
    currentUser = null;
    AppLogger.info("User logged out", tag: "AUTH_VM");
  }
}