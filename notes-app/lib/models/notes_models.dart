class NoteModels {
  final String title, id, description;

  NoteModels({
    required this.title,
    required this.id,
    required this.description,
  });

  factory NoteModels.fromJson(Map<String, Object?> json) {
    return NoteModels(
      title: json['title'].toString(),
      id: json['id'].toString(),
      description: json['description'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
