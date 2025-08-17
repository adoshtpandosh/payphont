const String content = '''import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinLoginPage extends StatefulWidget {
  const PinLoginPage({super.key});

  @override
  State<PinLoginPage> createState() => _PinLoginPageState();
}

class _PinLoginPageState extends State<PinLoginPage> {
  final LocalAuthentication _auth = LocalAuthentication();
  final TextEditingController _pinCtrl = TextEditingController();

  Future<bool> _checkPin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('pin') == pin;
  }

  void _login() async {
    final isValid = await _checkPin(_pinCtrl.text);
    if (isValid) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('رمز اشتباه است')));
    }
  }

  void _biometricLogin() async {
    final isAvailable = await _auth.canCheckBiometrics;
    if (isAvailable) {
      final didAuth = await _auth.authenticate(
        localizedReason: 'ورود با اثر انگشت',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuth) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ورود به پی‌فانت', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              controller: _pinCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'رمز عبور'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text('ورود')),
            const SizedBox(height: 10),
            TextButton.icon(
              icon: const Icon(Icons.fingerprint),
              label: const Text('ورود با اثر انگشت'),
              onPressed: _biometricLogin,
            ),
          ],
        ),
      ),
    );
  }
}''';