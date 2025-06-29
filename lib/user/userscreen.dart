import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
      ),
      body: Center(
        child: Text(
          'This is the User Screen',
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
    );
  }
}