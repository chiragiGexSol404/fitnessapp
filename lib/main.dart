import 'package:fitnessapp/views/login_screen.dart';
import 'package:fitnessapp/views/users_view.dart';
import 'package:fitnessapp/views/walcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WalcomeScreen(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => WalcomeScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/users', page: () => UsersView()),
      ],
    );
  }
}
