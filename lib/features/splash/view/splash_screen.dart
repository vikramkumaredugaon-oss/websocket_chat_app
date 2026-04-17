import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:websocket_chat/features/auth/view/login_view.dart';
import 'package:websocket_chat/features/dashboard/view/dashboard_view.dart';
import 'package:websocket_chat/features/onboarding/view/onboarding_screen.dart';

import '../../../core/storage/local_storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TickerProviderStateMixin {

  late AnimationController gradientController;
  late AnimationController logoController;
  late AnimationController pulseController;

  late Animation<double> logoScale;

  @override
  void initState() {
    super.initState();

    gradientController =
    AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat();

    logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    pulseController =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);

    logoScale = CurvedAnimation(
      parent: logoController,
      curve: Curves.elasticOut,
    );

    logoController.forward();

    Future.delayed(const Duration(seconds: 4), checkLogin);
  }

  Future checkLogin() async {

    bool isLoggedIn = LocalStorage.isLoggedInSync();
    bool onboardingSeen = LocalStorage.getOnboardingSeenSync();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardView()),
      );
    }
    else if (!onboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingView()),
      );
    }
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  void dispose() {
    gradientController.dispose();
    logoController.dispose();
    pulseController.dispose();
    super.dispose();
  }

  /// 🫧 Smooth Floating Bubble
  Widget bubble(double left, double size) {
    return AnimatedBuilder(
      animation: gradientController,
      builder: (_, __) {
        double progress = gradientController.value;
        return Positioned(
          bottom: -100 + (progress * MediaQuery.of(context).size.height * 1.2),
          left: left,
          child: Opacity(
            opacity: .2,
            child: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: size,
            ),
          ),
        );
      },
    );
  }

  /// 💬 Typing Animation
  Widget typing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Dot(),
        Dot(delay: 200),
        Dot(delay: 400),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: gradientController,
        builder: (_, __) {

          double value = gradientController.value;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color(0xff0f2027),
                  Color(0xff2c5364),
                  Color(0xff00c6ff),
                  Color(0xff0072ff),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  value,
                  (value + .2).clamp(0.0, 1.0),
                  (value + .4).clamp(0.0, 1.0),
                  (value + .6).clamp(0.0, 1.0),
                ],
              ),
            ),
            child: Stack(
              children: [

                /// 🫧 Bubbles
                bubble(40, 30),
                bubble(120, 35),
                bubble(220, 28),
                bubble(300, 40),
                bubble(180, 25),

                /// 🧊 Center Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /// 🔥 Glass Logo
                      ScaleTransition(
                        scale: logoScale,
                        child: AnimatedBuilder(
                          animation: pulseController,
                          builder: (_, __) {
                            return Container(
                              height: 140 + pulseController.value * 12,
                              width: 140 + pulseController.value * 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.cyanAccent.withOpacity(.3),
                                    blurRadius: 30,
                                    spreadRadius: 3,
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 18, sigmaY: 18),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.12),
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                        color: Colors.white24,
                                      ),
                                    ),
                                    child: Image.asset(
                                      "assets/images/splash_logo.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 35),

                      /// 🧾 App Name
                      const Text(
                        "ChatNova",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Lightning fast conversations",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// 💬 Typing
                      typing(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// 🔘 Typing Dot
class Dot extends StatefulWidget {
  final int delay;
  const Dot({super.key, this.delay = 0});

  @override
  State<Dot> createState() => _DotState();
}

class _DotState extends State<Dot>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: CircleAvatar(
          radius: 4,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}