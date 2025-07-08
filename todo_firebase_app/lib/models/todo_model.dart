// Model data tugas untuk To-Do List App
// TODO: Tambahkan field sesuai kebutuhan

class TodoModel {
  final String id;
  final String title;
  final bool isDone;

  TodoModel({required this.id, required this.title, required this.isDone});

  factory TodoModel.fromFirestore(dynamic doc) {
    final data = doc.data();
    return TodoModel(
      id: doc.id,
      title: data['title'] ?? '',
      isDone: data['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
} 