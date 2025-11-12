import 'package:flutter/material.dart';
import 'package:insyder/app_router.dart';
import 'package:insyder/core/utils/secure_storage.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/launch_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _controller.forward();

    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    final isFirstTime = await LaunchStorage.isFirstLaunch();

    if (isFirstTime) {
      Navigator.pushReplacementNamed(context, AppRoutes.register);
      return;
    }

    final token = await SecureStorageService.getToken();
    if (token != null && token.isNotEmpty) {
      // ApiService.setAuthToken(token);

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightSurface,
      body: Center(
        child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              "assets/logo.png",
              width: double.infinity,
              fit: BoxFit.cover,
            )
            // Icon(
            //   Icons.camera,
            //   color: Colors.indigo,
            //   size: 64.sp,
            // ),
            ),
      ),
    );
  }
}
