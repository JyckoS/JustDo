class Todo {
  String? id; // from RESTAPI UUID
  String title;
  bool completed;

  Todo({this.id, required this.title, this.completed = false});

  // helper for converting from/to json later
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'] ?? 'Title is Null',
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
