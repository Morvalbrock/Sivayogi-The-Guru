class SubCourse {
  final String titleEnglish;
  final String titleTamil;
  final String contentEnglish;
  final String contentTamil;

  SubCourse({
    required this.titleEnglish,
    required this.titleTamil,
    required this.contentEnglish,
    required this.contentTamil,
  });

  factory SubCourse.fromJson(Map<String, dynamic> json) {
    return SubCourse(
      titleEnglish: json['title_english'],
      titleTamil: json['title_tamil'],
      contentEnglish: json['content_english'],
      contentTamil: json['content_tamil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title_english': titleEnglish,
      'title_tamil': titleTamil,
      'content_english': contentEnglish,
      'content_tamil': contentTamil,
    };
  }
}

class Course {
  final String titleEnglish;
  final String titleTamil;
  final List<SubCourse> subCourses;

  Course({
    required this.titleEnglish,
    required this.titleTamil,
    required this.subCourses,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var list = json['sub_courses'] as List;
    List<SubCourse> subCourseList =
        list.map((i) => SubCourse.fromJson(i)).toList();

    return Course(
      titleEnglish: json['title_english'],
      titleTamil: json['title_tamil'],
      subCourses: subCourseList,
    );
  }
// json object
  Map<String, dynamic> toJson() {
    return {
      'title_english': titleEnglish,
      'title_tamil': titleTamil,
      'sub_courses': subCourses.map((e) => e.toJson()).toList(),
    };
  }
}
