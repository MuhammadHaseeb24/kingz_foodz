import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/main_nav_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController(text: 'demo@kingsfoodz.com');
  final _passCtrl = TextEditingController(text: '123456');
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() async {
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    final auth = context.read<AuthProvider>();
    final error = auth.login(_emailCtrl.text, _passCtrl.text);
    if (!mounted) return;
    setState(() => _loading = false);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppColors.danger),
      );
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.maroon,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.emoji_events_rounded, color: AppColors.gold, size: 32),
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome back',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Login to order food fit for a King',
                style: TextStyle(color: AppColors.grey, fontSize: 15),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: _emailCtrl,
                label: 'Email or Phone',
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),
              CustomTextField(
                controller: _passCtrl,
                label: 'Password',
                hint: 'Enter your password',
                icon: Icons.lock_outline_rounded,
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password reset link sent (demo)')),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.4),
                        )
                      : const Text('Log In'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or continue with', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _SocialButton(icon: Icons.g_mobiledata_rounded, label: 'Google', onTap: _login)),
                  const SizedBox(width: 14),
                  Expanded(child: _SocialButton(icon: Icons.facebook_rounded, label: 'Facebook', onTap: _login)),
                ],
              ),
              const SizedBox(height: 28),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: AppColors.grey, fontSize: 14),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(color: AppColors.maroon, fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const SignupScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Demo login: demo@kingsfoodz.com / 123456',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 22),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),
        foregroundColor: AppColors.charcoal,
      ),
    );
  }
}

