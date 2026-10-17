import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maroon,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gold, width: 3),
              ),
              child: const Icon(Icons.emoji_events_rounded, color: AppColors.gold, size: 48),
            ),
            const SizedBox(height: 20),
            const Text(
              "KING'S FOODZ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Food fit for a King',
              style: TextStyle(color: AppColors.goldLight, fontSize: 14, letterSpacing: 0.6),
            ),
            const SizedBox(height: 36),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 2.6),
            ),
          ],
        ),
      ),
    );
  }
}
