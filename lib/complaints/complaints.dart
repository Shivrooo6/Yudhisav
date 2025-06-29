import 'package:flutter/material.dart';

class Complaint extends StatelessWidget {
  const Complaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints'),
      ),
      body: Center(
        child: Text(
          'This is the Complaints Screen',
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
    );
  }
}