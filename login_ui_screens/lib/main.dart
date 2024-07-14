import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:login_ui_screens/Provider/api_provider.dart';
import 'package:login_ui_screens/Provider/auth_provider.dart';
import 'package:login_ui_screens/Screen/gate.dart';
import 'package:login_ui_screens/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  Hive.openBox("app");
  Supabase.initialize(
      url: ApiDetails().supabase_url, anonKey: ApiDetails().supabase_api);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Color backgroundColor1 = const Color(0xffE9EAF7);
Color backgroundColor2 = const Color(0xffF4EEF2);
Color backgroundColor3 = const Color(0xffEBEBF2);
Color backgroundColor4 = const Color(0xffE3EDF5);
Color primaryColor = const Color(0xffD897FD);
Color textColor1 = const Color(0xff353047);
Color textColor2 = const Color(0xff6F6B7A);
Color buttonColor = const Color(0xffFD6B68);

Color btncolor(double x) {
  return Color.fromRGBO(20, 25, 122, x);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthernicationProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Gate(),
      ),
    );
  }
}
