import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/session_service.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final String nimPassword = '124240015';

  void _login() {
    final user = _userCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    print('-----------------------------------------');
    print('Username diketik : "$user"');
    print('Password diketik : "$pass"');
    print('Password di kode : "$nimPassword"');
    print('-----------------------------------------');

    if (user.isEmpty || pass.isEmpty) {
      Get.snackbar('Error', 'Username dan password wajib diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (pass != nimPassword) {
      Get.snackbar('Error', 'Password harus NIM kamu!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    SessionService.login(user).then((_) {
      Get.offAll(() => const MainPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag,
                    size: 80, color: Color(0xFFFFB6C1)),
                const SizedBox(height: 12),
                const Text('Elora Mart',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD87093))),
                const SizedBox(height: 40),
                TextField(
                  controller: _userCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Color(0xFFD87093)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFFFB6C1), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Password (NIM)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFFD87093)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFFFB6C1), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB6C1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text('Login',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
