import 'package:cidadania_participativa/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

/*
class Application extends StatelessWidget {
  Application({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //debugShowCheckedModeBanner: false,
      initialRoute: '/menu_page',
      getPages: [
        GetPage(name: '/login_page', page: () => LoginPage()),
        GetPage(name: '/menu_page', page: () => MenuPage()),
        GetPage(name: '/add_report_page', page: () => AddReportPage())
      ],
    );
  }
}*/