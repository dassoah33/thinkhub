class Idea {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String status;
  final String? projectId;

  const Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.status = 'idea',
    this.projectId,
  });

  Idea copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    String? status,
    String? projectId,
  }) {
    return Idea(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'project_id': projectId,
    };
  }

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: json['status'] as String? ?? 'idea',
      projectId: json['project_id'] as String?,
    );
  }
}
