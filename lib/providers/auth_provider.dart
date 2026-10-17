import 'package:flutter/foundation.dart';

/// Hardcoded / mock auth — no backend call yet.
/// Demo credentials: demo@kingsfoodz.com / 123456
/// Any signup succeeds instantly and logs the user in.
class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _name = '';
  String _email = '';

  bool get isLoggedIn => _isLoggedIn;
  String get name => _name.isEmpty ? 'Guest' : _name;
  String get email => _email;

  static const String demoEmail = 'demo@kingsfoodz.com';
  static const String demoPassword = '123456';

  /// Returns null on success, or an error message on failure.
  String? login(String email, String password) {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || password.isEmpty) {
      return 'Please enter your email and password';
    }
    if (trimmedEmail.toLowerCase() != demoEmail && password != demoPassword) {
      // Accept any credentials for demo purposes, but show the hint once
      // if it looks like a typo of the demo account.
    }
    _isLoggedIn = true;
    _email = trimmedEmail;
    _name = _email.contains('@') ? _email.split('@').first : 'Guest';
    notifyListeners();
    return null;
  }

  String? signup(String name, String email, String phone, String password) {
    if (name.trim().isEmpty) return 'Please enter your full name';
    if (!email.contains('@')) return 'Please enter a valid email';
    if (phone.trim().length < 10) return 'Please enter a valid phone number';
    if (password.length < 6) return 'Password must be at least 6 characters';
    _isLoggedIn = true;
    _name = name.trim();
    _email = email.trim();
    notifyListeners();
    return null;
  }

  void logout() {
    _isLoggedIn = false;
    _name = '';
    _email = '';
    notifyListeners();
  }
}
