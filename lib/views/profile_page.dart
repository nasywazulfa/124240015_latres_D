import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/session_service.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = SessionService.getUsername();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xFFFFB6C1),
                backgroundImage: const NetworkImage(
                  'https://api.dicebear.com/7.x/adventurer/png?seed=nasywa&backgroundColor=ffb6c1',
                ),
              ),
              const SizedBox(height: 16),

    
              Text(username,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD87093))),
              const SizedBox(height: 8),

           
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Hanya seorang mahasiswa yang sedang belajar Flutter untuk responsi mobile.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 32),

         
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB6C1),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  await SessionService.logout();
                  Get.offAll(() => const LoginPage());
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
