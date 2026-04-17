import 'package:flutter/material.dart';
import 'package:websocket_chat/core/theme/colors.dart';
import '../../../core/base/base_view.dart';
import '../../../core/base/view_state.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../widgets/app_textfield.dart';
import '../../../widgets/primary_button.dart';
import '../viewmodel/auth_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                padding: EdgeInsets.only(top: 200,left: 20),
                child: Text(AppStrings.login,style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300, left: 16, right: 16),
                child: Form(
                  key: vm.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        hintText: AppStrings.enterEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                        onChanged: vm.setEmail,
                        prefixIcon: const Icon(Icons.email),
                      ),

                      SizedBox(height: 16),

                      AppTextField(
                        hintText: AppStrings.enterPassword,
                        obscureText: true,
                        validator: Validators.password,
                        onChanged: vm.setPassword,
                        prefixIcon: Icon(Icons.lock),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/register");
                            },
                            child: const Text(AppStrings.register,style: TextStyle(color: AppColors.textPrimary),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/register");
                            },
                            child: Text(AppStrings.forgotPassword,style: TextStyle(color: AppColors.error),),
                          ),
                        ],
                      ),


                      SizedBox(height: 15),
                      PrimaryButton(
                        text: AppStrings.login,
                        onPressed: () async {
                          final success = await vm.login();
                          if (success && context.mounted) {
                            Navigator.pushReplacementNamed(context, "/bottomNavigation",);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: Divider(indent: 10,endIndent: 10,)),
                          Text("Or"),
                          Expanded(child: Divider(indent: 10,endIndent: 10,)),
                        ],
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(height: 60, width: 60,
                                padding: const EdgeInsets.all(17),
                                child: Image.asset("assets/images/img.png", fit: BoxFit.contain,),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Center(
                            child: SizedBox(height: 68,width: 68,
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.call,color: AppColors.chatBubbleMe,size: 30,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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