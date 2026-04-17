import 'package:flutter/material.dart';
import 'package:websocket_chat/core/theme/colors.dart';

import '../../../core/base/base_view.dart';
import '../../../core/base/view_state.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../widgets/app_textfield.dart';
import '../../../widgets/primary_button.dart';
import '../viewmodel/auth_viewmodel.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
                          hintText: "Enter Name",
                          validator: Validators.name,
                          onChanged: vm.setName,
                          prefixIcon: const Icon(Icons.person),
                        ),

                        const SizedBox(height: 16),

                        /// 📧 Email
                        AppTextField(
                          hintText: AppStrings.enterEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                          onChanged: vm.setEmail,
                          prefixIcon: const Icon(Icons.email),
                        ),

                        const SizedBox(height: 16),

                        /// 🔐 Password
                        AppTextField(
                          hintText: AppStrings.enterPassword,
                          obscureText: true,
                          validator: Validators.password,
                          onChanged: vm.setPassword,
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
                            final success = await vm.register();
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