import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'models/cart_model.dart';
import 'services/session_service.dart';
import 'views/login_page.dart';
import 'views/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartModelAdapter());
  await Hive.openBox<CartModel>('cartBox');

  await SessionService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = SessionService.isLoggedIn();


    const Color softPink = Color(0xFFFFB6C1); 
    const Color darkPink = Color(0xFFD87093); 

    return GetMaterialApp(
      title: 'Toko Awekwoi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: softPink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: softPink,
          primary: softPink,
        ),


        scaffoldBackgroundColor: const Color(0xFFFFF0F5), 
        

        appBarTheme: const AppBarTheme(
          backgroundColor: softPink,
          foregroundColor: Colors.white, 
          elevation: 0,
        ),
        

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: softPink,
            foregroundColor: darkPink, 
          ),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: darkPink,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),
      home: isLoggedIn ? const MainPage() : const LoginPage(),
    );
  }
}