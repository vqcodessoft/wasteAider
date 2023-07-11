import 'package:flutter/material.dart';
import 'package:wasteaider/screens/choose.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseUserAdmin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Center(
        child: Text(
          'Welcome to WasteAider',
          style: TextStyle(fontSize: 24),
        ),
      )),
    );
  }
}
