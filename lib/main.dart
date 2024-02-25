import 'package:flutter/material.dart';
import 'package:liveasy/MobileNumberPage.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context)=>OTPProvider(),
    child: const TaskApp(),
  ));
}

class TaskApp extends StatelessWidget {
  const TaskApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(key: UniqueKey()), // Providing a UniqueKey to HomePage
    );
  }
}
