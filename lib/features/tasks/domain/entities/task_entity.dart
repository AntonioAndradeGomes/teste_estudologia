import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? content;
  final String? description;
  final String? createdAt;
  final String? taskCompletionDate;

  const TaskEntity({
    this.id,
    required this.content,
    required this.description,
    required this.createdAt,
    this.taskCompletionDate,
  });

  TaskEntity copyWith({
    int? id,
    String? content,
    String? description,
    String? createdAt,
    String? taskCompletionDate,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      taskCompletionDate: taskCompletionDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        content,
        description,
        createdAt,
        taskCompletionDate,
      ];

  DateTime get createdAtForDate => DateTime.parse(createdAt!);

  DateTime get taskCompletionDateForDate => DateTime.parse(taskCompletionDate!);
  @override
  String toString() {
    return 'TaskEntity{id: $id, content: $content, description: $description, createdAt: $createdAt, taskCompletionDate: $taskCompletionDate}';
  }
}
