class Task {
  int? id;
  String title;
  //DateTime date;
  String alertAt;
  bool isDone;

  Task({
    this.id,
    required this.title,
    //required this.date,
    required this.alertAt,
    required this.isDone,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      //date: DateTime.parse(json['date']),
      alertAt: json['alertAt'],
      isDone: json['isDone'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      //'date': date.toIso8601String(),
      'alertAt': alertAt,
      'isDone': isDone ? 1 : 0,
    };
  }
}
