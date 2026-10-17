import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final _nameCtrl = TextEditingController(text: MockData.userName);
  late final _emailCtrl = TextEditingController(text: MockData.userEmail);
  late final _phoneCtrl = TextEditingController(text: MockData.userPhone);
  late final _addressCtrl = TextEditingController(text: MockData.deliveryAddress);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(controller: _nameCtrl, label: 'Full Name', hint: 'Your name', icon: Icons.person_outline_rounded),
          const SizedBox(height: 16),
          CustomTextField(controller: _emailCtrl, label: 'Email', hint: 'Your email', icon: Icons.mail_outline_rounded),
          const SizedBox(height: 16),
          CustomTextField(controller: _phoneCtrl, label: 'Phone', hint: 'Your phone number', icon: Icons.phone_outlined),
          const SizedBox(height: 16),
          CustomTextField(controller: _addressCtrl, label: 'Delivery Address', hint: 'Your address', icon: Icons.location_on_outlined),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated (demo)')),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
