import 'package:flutter/material.dart';

class GymHomeScreen extends StatefulWidget {
  const GymHomeScreen({super.key});

  @override
  State<GymHomeScreen> createState() => _GymHomeScreenState();
}

class _GymHomeScreenState extends State<GymHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: Text('GymHomeScreen'),
      ),
    ));
  }
}
