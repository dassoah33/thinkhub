class Project {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? endDate;
  final String status;
  final List<String> ideaIds;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.endDate,
    this.status = 'planning',
    this.ideaIds = const [],
  });

  Project copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? endDate,
    String? status,
    List<String>? ideaIds,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      ideaIds: ideaIds ?? this.ideaIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'idea_ids': ideaIds,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      status: json['status'] as String? ?? 'planning',
      ideaIds: (json['idea_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
