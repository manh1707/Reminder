import 'package:flutter/material.dart';
import 'package:reminder/const/assets.dart';
import 'package:reminder/const/color.dart';
import 'package:reminder/const/font.dart';

class StandUpPage extends StatelessWidget {
  const StandUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        title: Text(
          "Stand up",
          style: heading3.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: _drawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 120),
          Center(child: Image.asset(MyAssets.centerCireclePath)),
        ],
      ),
    );
  }

  Drawer _drawer() {
    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
