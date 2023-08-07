import 'package:beh_pouyan_test/screens/home/home.dart';
import 'package:beh_pouyan_test/screens/root.dart';
import 'package:beh_pouyan_test/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BehPouyan Test',
      themeMode: ThemeMode.dark,
      theme: MyAppThemeConfig.dark().getTheme(),
      home: const RootScreen(),
    );
  }
}
