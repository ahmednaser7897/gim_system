import 'package:flutter/material.dart';
import 'package:gim_system/ui/componnents/log_out_button.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [const Text('UserHomeScreen'), LogOutButton(onTap: () {})],
        ),
      ),
    ));
  }
}
