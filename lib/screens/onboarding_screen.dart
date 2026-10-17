import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'auth/login_screen.dart';

class _OnboardPage {
  final IconData icon;
  final String title;
  final String subtitle;
  const _OnboardPage(this.icon, this.title, this.subtitle);
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<_OnboardPage> _pages = const [
    _OnboardPage(
      Icons.location_on_rounded,
      'Discover food near you',
      'Find the best restaurants and dishes around your location in seconds.',
    ),
    _OnboardPage(
      Icons.auto_awesome_rounded,
      'Ask our AI Assistant',
      'Just say what you\'re craving — the AI finds the perfect match for your budget and taste.',
    ),
    _OnboardPage(
      Icons.delivery_dining_rounded,
      'Track your order live',
      'Watch your rider on the map from kitchen to doorstep, every step of the way.',
    ),
  ];

  void _finish() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text('Skip', style: TextStyle(color: AppColors.grey)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final page = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: AppColors.goldLight.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(page.icon, size: 80, color: AppColors.maroon),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15, color: AppColors.grey, height: 1.4),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _index == i ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _index == i ? AppColors.maroon : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_index == _pages.length - 1) {
                      _finish();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(_index == _pages.length - 1 ? 'Get Started' : 'Next'),
                ),
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
