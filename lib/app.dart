import 'package:flutter/material.dart';
import 'package:textfield_paste/paste_demo_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextField Paste Overwrite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PasteDemoPage(),
    );
  }
}
