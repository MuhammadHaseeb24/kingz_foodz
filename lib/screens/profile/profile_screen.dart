import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock_data.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 34,
                backgroundColor: AppColors.maroon,
                child: Icon(Icons.person_rounded, color: Colors.white, size: 34),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(auth.isLoggedIn ? auth.name : MockData.userName,
                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text(auth.isLoggedIn ? auth.email : MockData.userEmail,
                        style: const TextStyle(color: AppColors.grey, fontSize: 13)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _ProfileTile(icon: Icons.location_on_outlined, label: 'Saved Addresses', onTap: () {}),
          _ProfileTile(icon: Icons.payment_outlined, label: 'Payment Methods', onTap: () {}),
          _ProfileTile(icon: Icons.local_offer_outlined, label: 'Coupons & Offers', onTap: () {}),
          _ProfileTile(icon: Icons.notifications_none_rounded, label: 'Notification Settings', onTap: () {}),
          _ProfileTile(icon: Icons.support_agent_rounded, label: 'Help & Support', onTap: () {}),
          _ProfileTile(icon: Icons.info_outline_rounded, label: 'About King\'s Foodz', onTap: () {}),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _ProfileTile(
            icon: Icons.logout_rounded,
            label: 'Log Out',
            color: AppColors.danger,
            onTap: () {
              context.read<AuthProvider>().logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const _ProfileTile({required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.charcoal;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: c),
      title: Text(label, style: TextStyle(color: c, fontWeight: FontWeight.w600)),
      trailing: color == null ? const Icon(Icons.chevron_right_rounded, color: AppColors.grey) : null,
      onTap: onTap,
    );
  }
}
