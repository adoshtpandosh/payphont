const String content = '''import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final _oldCtrl = TextEditingController();
  final _newCtrl = TextEditingController();

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final old = prefs.getString('pin');
    if (old == _oldCtrl.text) {
      await prefs.setString('pin', _newCtrl.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('PIN تغییر کرد')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('PIN قبلی اشتباه است')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تغییر PIN')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _oldCtrl,
              decoration: const InputDecoration(labelText: 'PIN فعلی'),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            TextField(
              controller: _newCtrl,
              decoration: const InputDecoration(labelText: 'PIN جدید'),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: const Text('ذخیره')),
          ],
        ),
      ),
    );
  }
}''';