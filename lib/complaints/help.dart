import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Need Help?'),
        backgroundColor: const Color.fromARGB(255, 10, 85, 136),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Having Trouble Getting Help?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'If you have already submitted a complaint and haven’t received any help yet, please consider the following:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),

          const Divider(),
          const Text(
            'Common Questions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildFAQ(
            question: 'How long does it take to get a response?',
            answer: 'Usually within 24–48 hours. Please be patient while we review your complaint.',
          ),
          _buildFAQ(
            question: 'What if I made a mistake in the complaint?',
            answer: 'You can re-submit a complaint with correct details or contact support.',
          ),
          _buildFAQ(
            question: 'How do I track my complaint status?',
            answer: 'Currently, you can’t track status. You will be contacted by our team once reviewed.',
          ),
          const SizedBox(height: 20),
          const Divider(),

          const Text(
            'Still need help?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.edit_note),
            label: const Text('Submit Another Complaint'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 43, 58, 128),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // Navigate to complaint form
              Navigator.pushNamed(context, '/complaint'); // Adjust as needed
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.email),
            label: const Text('Contact Support'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade800,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // You can open email or another screen
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Contact Support'),
                  content: const Text('Please email us at: support@example.com'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(answer),
        ],
      ),
    );
  }
}
