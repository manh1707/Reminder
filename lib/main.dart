import 'package:flutter/material.dart';
import 'package:reminder/page/standup_page.dart';
import 'package:reminder/utils/router.dart';

void main() async {
  // await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => MyAppRouter.generateRoute(settings),
      home: const StandUpPage(),
    );
  }
}
