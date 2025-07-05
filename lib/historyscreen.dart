import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // 🌈 Choose your AppBar color here:
  static const Color appBarColor = Color.fromARGB(255, 231, 162, 12); // light blue example

  // 🎨 Example palette:
  // Color(0xFFF54A00) - orange
  // Color(0xFF4A90E2) - light blue
  // Color(0xFF50E3C2) - teal
  // Color(0xFF9013FE) - purple
  // Color(0xFFB8E986) - light green

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to view your complaint history.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Complaint History'),
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .where('userId', isEqualTo: user.uid) // filter by userId
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No complaints found.'));
          }

          final complaints = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              final title = complaint['title'] ?? 'No Title';
              final description = complaint['description'] ?? 'No Description';
              final status = complaint['status'] ?? 'pending';
              final timestamp = complaint['timestamp'] as Timestamp?;
              final date = timestamp?.toDate();

              final formattedDate = date != null
                  ? DateFormat('dd/MM/yyyy, hh:mm a').format(date)
                  : 'Unknown date';

              Color statusColor;
              switch (status.toLowerCase()) {
                case 'resolved':
                case 'completed':
                  statusColor = Colors.green;
                  break;
                case 'rejected':
                  statusColor = Colors.red;
                  break;
                default:
                  statusColor = Colors.lightBlue;
              }

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(description),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Status: '),
                          Text(
                            status[0].toUpperCase() + status.substring(1),
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('Submitted on: $formattedDate'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
