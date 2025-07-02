class Course {
  final String title;
  final List<Lecture> lectures;

  Course({
    required this.title,
    required this.lectures,
  });
}

class Lecture {
  final String title;
  final String videoUrl;
  final String notes;
  final List<String> quizQuestions;

  Lecture({
    required this.title,
    required this.videoUrl,
    required this.notes,
    required this.quizQuestions,
  });
}
