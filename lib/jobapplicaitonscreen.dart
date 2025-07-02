import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobApplicationScreen extends StatefulWidget {
  const JobApplicationScreen({super.key});

  @override
  State<JobApplicationScreen> createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController resumeLinkController = TextEditingController();

  bool isLoading = false;

  Future<void> submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => isLoading = true);

      await FirebaseFirestore.instance.collection('job_applications').add({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'qualification': qualificationController.text.trim(),
        'experience': experienceController.text.trim(),
        'resumeUrl': resumeLinkController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted successfully!')),
      );

      // Clear form
      nameController.clear();
      phoneController.clear();
      qualificationController.clear();
      experienceController.clear();
      resumeLinkController.clear();
    } catch (e) {
      print('Error submitting application: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit. Try again.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Application'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Fill out the form to apply for jobs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder()),
                validator: (value) => value!.length < 8 ? 'Enter valid phone number' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: qualificationController,
                decoration: const InputDecoration(labelText: 'Qualification', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Enter your qualification' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: experienceController,
                decoration: const InputDecoration(labelText: 'Experience (years)', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Enter your experience' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: resumeLinkController,
                decoration: const InputDecoration(
                  labelText: 'Resume link (Google Drive/Dropbox/OneDrive)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please paste your resume link' : null,
              ),
              const SizedBox(height: 20),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: submitApplication,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.orangeAccent,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Submit Application'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
