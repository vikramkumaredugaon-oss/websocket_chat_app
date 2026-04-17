import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/base/base_view.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardingViewModel>(
      viewModel: OnboardingViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff0f2027),
                  Color(0xff2c5364),
                  Color(0xff00c6ff),
                  Color(0xff0072ff),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: Stack(
              children: [

                /// 📱 Pages
                PageView(
                  controller: vm.controller,
                  onPageChanged: vm.onPageChanged,
                  children: [

                    buildPage(
                      "assets/animations/chat1.json",
                      "Instant Messaging",
                      "Send messages instantly with real-time speed.",
                    ),

                    buildPage(
                      "assets/animations/message.json",
                      "Fast Conversations",
                      "Experience lightning fast chat powered by WebSocket.",
                    ),

                    buildPage(
                      "assets/animations/connection.json",
                      "Stay Connected",
                      "Connect with your friends anywhere anytime.",
                    ),
                  ],
                ),

                /// 🔽 Bottom Controls
                Align(
                  alignment: const Alignment(0, 0.85),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// 🔘 Indicator
                      SmoothPageIndicator(
                        controller: vm.controller,
                        count: 3,
                        effect: const WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          activeDotColor: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// 🔥 Button
                      GestureDetector(
                        onTap: () => vm.onNext(context),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 120,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white30,
                                ),
                              ),
                              child: Text(
                                vm.lastPage ? "Get Started" : "Next",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 📦 Page UI
  Widget buildPage(String animation, String title, String desc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        /// 🧊 Glass Card
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withOpacity(.15),
                border: Border.all(color: Colors.white30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.25),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Lottie.asset(
                  animation,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 40),

        /// 🧾 Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        /// 📄 Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}