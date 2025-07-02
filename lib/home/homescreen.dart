import 'package:flutter/material.dart';
import 'package:yudhisav/course.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Color primaryColor = const Color.fromARGB(255, 2, 171, 194); // Deep teal
  final Color accentColor = const Color(0xFFFF7043); // Vibrant orange

  final List<Course> courses = [
    Course(
      title: 'Trading',
      lectures: [
        Lecture(
          title: 'Basics of Trading',
          videoUrl: 'gs://yudhisav.firebasestorage.app/UGROW FUN @ 1 EXPPP.mp4',
          notes: 'Introduction to stock and forex markets.',
          quizQuestions: ['What is trading?', 'Name one type of market.'],
        ),
        Lecture(
          title: 'Technical Analysis',
          videoUrl: 'https://example.com/trading2.mp4',
          notes: 'Charts, patterns, and indicators.',
          quizQuestions: ['What is RSI?', 'Define candlestick.'],
        ),
      ],
    ),
    Course(
      title: 'Web Development',
      lectures: [
        Lecture(
          title: 'HTML & CSS',
          videoUrl: 'https://example.com/web1.mp4',
          notes: 'Building blocks of the web.',
          quizQuestions: ['What does HTML stand for?', 'What is CSS used for?'],
        ),
        Lecture(
          title: 'JavaScript Basics',
          videoUrl: 'https://example.com/web2.mp4',
          notes: 'Make your sites interactive.',
          quizQuestions: ['What is DOM?', 'Define variable.'],
        ),
      ],
    ),
    Course(
      title: 'App Development',
      lectures: [
        Lecture(
          title: 'Flutter Intro',
          videoUrl: 'https://example.com/app1.mp4',
          notes: 'Cross-platform mobile apps.',
          quizQuestions: ['What is Flutter?', 'Who developed Flutter?'],
        ),
        Lecture(
          title: 'State Management',
          videoUrl: 'https://example.com/app2.mp4',
          notes: 'Manage app data flow.',
          quizQuestions: ['What is Provider?', 'Why is state important?'],
        ),
      ],
    ),
    Course(
      title: 'Digital Marketing',
      lectures: [
        Lecture(
          title: 'Social Media Marketing',
          videoUrl: 'https://example.com/dm1.mp4',
          notes: 'Using platforms to grow brand awareness.',
          quizQuestions: ['Name a social platform.', 'What is engagement?'],
        ),
        Lecture(
          title: 'SEO Basics',
          videoUrl: 'https://example.com/dm2.mp4',
          notes: 'Improve website visibility.',
          quizQuestions: ['What does SEO stand for?', 'What is a keyword?'],
        ),
      ],
    ),
    Course(
      title: 'Business Development',
      lectures: [
        Lecture(
          title: 'Finding Clients',
          videoUrl: 'https://example.com/biz1.mp4',
          notes: 'Prospecting and outreach.',
          quizQuestions: ['What is prospecting?', 'Define lead.'],
        ),
        Lecture(
          title: 'Building Partnerships',
          videoUrl: 'https://example.com/biz2.mp4',
          notes: 'Creating win-win collaborations.',
          quizQuestions: ['What is a partnership?', 'Why is networking important?'],
        ),
      ],
    ),
    Course(
      title: 'Human Physiology',
      lectures: [
        Lecture(
          title: 'Digestive System',
          videoUrl: 'https://example.com/physio1.mp4',
          notes: 'How we process food.',
          quizQuestions: ['Name one digestive organ.', 'What is digestion?'],
        ),
        Lecture(
          title: 'Nervous System',
          videoUrl: 'https://example.com/physio2.mp4',
          notes: 'Control and coordination.',
          quizQuestions: ['What is a neuron?', 'What does CNS stand for?'],
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedCard(int index, Widget child) {
    final Animation<double> animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.1 * index, 0.6 + 0.1 * index, curve: Curves.easeOut),
    );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'युद्ध अपने ही विरुद्ध',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 6,
        shadowColor: accentColor.withOpacity(0.4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleTransition(
              scale: Tween(begin: 0.9, end: 1.0).animate(
                CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 97, 255, 247), Color.fromARGB(255, 92, 89, 84)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: accentColor.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: Column(
                  children: const [
                    Text(
                      'We take complaints from the public and try to fix their problems of any type.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16),
                    Icon(Icons.gavel, size: 50, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            _buildAnimatedCard(1, Row(
              children: [
                Expanded(child: _InfoCard(icon: Icons.verified, title: 'Trusted', subtitle: 'Community driven', iconColor: accentColor)),
                const SizedBox(width: 12),
                Expanded(child: _InfoCard(icon: Icons.flash_on, title: 'Fast', subtitle: 'Quick actions', iconColor: Colors.orangeAccent)),
              ],
            )),
            const SizedBox(height: 12),
            _buildAnimatedCard(2, Row(
              children: [
                Expanded(child: _InfoCard(icon: Icons.security, title: 'Secure', subtitle: 'Safe & private', iconColor: const Color.fromARGB(255, 255, 153, 0))),
                const SizedBox(width: 12),
                Expanded(child: _InfoCard(icon: Icons.support_agent, title: 'Support', subtitle: 'We listen', iconColor: Colors.blueAccent)),
              ],
            )),

            const SizedBox(height: 30),

            _buildAnimatedCard(3, SizedBox(
              width: double.infinity,
              child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack)),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/file-complaint');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 6, shadowColor: accentColor.withOpacity(0.4),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text('Write a Complaint', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            )),

            const SizedBox(height: 30),

            _buildAnimatedCard(4, const Text('Our Courses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            _buildAnimatedCard(5, Column(
              children: courses.map((course) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 3,
                  child: ListTile(
                    title: Text(course.title),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => LectureListScreen(course: course),
                      ));
                    },
                  ),
                );
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const _InfoCard({required this.icon, required this.title, required this.subtitle, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: iconColor.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          CircleAvatar(backgroundColor: iconColor.withOpacity(0.15), radius: 26, child: Icon(icon, color: iconColor, size: 28)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class LectureListScreen extends StatelessWidget {
  final Course course;

  const LectureListScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: ListView.builder(
        itemCount: course.lectures.length,
        itemBuilder: (_, index) {
          final lecture = course.lectures[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(lecture.title),
              trailing: const Icon(Icons.play_circle_fill),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LectureDetailScreen(lecture: lecture),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}

class LectureDetailScreen extends StatelessWidget {
  final Lecture lecture;

  const LectureDetailScreen({required this.lecture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lecture.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 180, color: Colors.black12, child: const Center(child: Icon(Icons.play_circle_fill, size: 50))),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.notes),
              label: const Text('View Notes'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Notes'),
                    content: Text(lecture.notes),
                    actions: [TextButton(child: const Text('Close'), onPressed: () => Navigator.pop(context))],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.quiz),
              label: const Text('Take Quiz'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Quiz Questions'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: lecture.quizQuestions.map((q) => Text('• $q')).toList(),
                    ),
                    actions: [TextButton(child: const Text('Close'), onPressed: () => Navigator.pop(context))],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
