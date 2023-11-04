import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:our_task/pages/homepage.dart';

void main() async {
  await Hive.initFlutter();
  //open a box
  var box = await Hive.openBox('todo');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Our App',
        home: const HomePage(),
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ));
  }
}
