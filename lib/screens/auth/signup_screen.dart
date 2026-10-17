import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/main_nav_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  bool _agree = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _signup() async {
    FocusScope.of(context).unfocus();
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms & Conditions')),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    final auth = context.read<AuthProvider>();
    final error = auth.signup(_nameCtrl.text, _emailCtrl.text, _phoneCtrl.text, _passCtrl.text);
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
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Join King\'s Foodz',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Create an account to start ordering',
                style: TextStyle(color: AppColors.grey, fontSize: 15),
              ),
              const SizedBox(height: 28),
              CustomTextField(
                controller: _nameCtrl,
                label: 'Full Name',
                hint: 'Muhammad Haseeb',
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailCtrl,
                label: 'Email',
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneCtrl,
                label: 'Phone Number',
                hint: '03xx xxxxxxx',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passCtrl,
                label: 'Password',
                hint: 'At least 6 characters',
                icon: Icons.lock_outline_rounded,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    activeColor: AppColors.maroon,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to the Terms & Conditions and Privacy Policy',
                      style: TextStyle(fontSize: 13, color: AppColors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _signup,
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.4),
                        )
                      : const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: AppColors.grey, fontSize: 14),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(color: AppColors.maroon, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
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
