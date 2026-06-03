import 'package:flutter/material.dart';
import 'package:websocket_chat/core/theme/colors.dart';

import '../../../core/base/base_view.dart';
import '../../../core/base/view_state.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/fcm/user_device_token_service.dart';
import '../../../core/utils/validators.dart';
import '../../../widgets/app_textfield.dart';
import '../../../widgets/primary_button.dart';
import '../viewmodel/auth_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      viewModel: AuthViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: -150,
                left: -70,
                child: Container(
                  height: 350,
                  width: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff2c5364),
                        Color(0xff2c5364),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -150,
                right: -40,
                child: Container(
                  height: 300,
                  width: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff2c5364),
                        Color(0xff2c5364),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 650,
                right: 250,
                child: Container(
                  height: 150,
                  width: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff2c5364),
                        Color(0xff2c5364),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 220,left: 16),
                child: Text(AppStrings.register,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300,right: 16,left: 16),
                child: Form(
                  key: vm.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          controller: _nameController,
                          hintText: "Enter Name",
                          validator: Validators.name,
                          prefixIcon: const Icon(Icons.person),
                        ),

                        AppTextField(
                          controller: _emailController,
                          hintText: AppStrings.enterEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                          prefixIcon: const Icon(Icons.email),
                        ),

                        AppTextField(
                          controller: _passwordController,
                          hintText: AppStrings.enterPassword,
                          obscureText: true,
                          validator: Validators.password,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: const Icon(Icons.visibility_off),
                        ),

                        const SizedBox(height: 16),

                        const SizedBox(height: 24),

                        /// 🔘 Register Button
                        PrimaryButton(
                          text: "Register",
                          isLoading: vm.state == ViewState.loading,
                          onPressed: () async {
                            final deviceToken=await UserDeviceTokenService.getDeviceToken();

                            // vm.setRegisterData(
                            //   name: _nameController.text,
                            //   email: _emailController.text,
                            //   password: _passwordController.text,
                            // );


                            final success = await vm.register(name: _nameController.text, email: _emailController.text, password: _passwordController.text, deviceToken:deviceToken!);
                            print("FCM device token store:- $deviceToken");

                            if (success && context.mounted) {
                              Navigator.pushReplacementNamed(context, "/login");
                            }
                          },
                        ),

                        const SizedBox(height: 16),

                        /// 🔁 Back to Login
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppStrings.alreadyAccount,style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}