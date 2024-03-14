import 'package:floor/floor.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

@Entity(
  tableName: 'task',
  primaryKeys: ['id'],
)
class TaskModel extends TaskEntity {
  const TaskModel({
    required int? id,
    String? content,
    String? description,
    String? createdAt,
    String? taskCompletionDate,
  }) : super(
          id: id,
          content: content,
          description: description,
          createdAt: createdAt,
          taskCompletionDate: taskCompletionDate,
        );

  factory TaskModel.fromJson(
    Map<String, dynamic> map,
  ) =>
      TaskModel(
        id: map['id'],
        content: map['content'] ?? '',
        description: map['description'] ?? '',
        createdAt: map['createdAt'],
        taskCompletionDate: map['taskCompletionDate'],
      );

  Map<String, dynamic> toMap() => {
        'id': id ?? '',
        'content': content ?? '',
        'description': description ?? '',
        'createdAt': createdAt ?? DateTime.now().toIso8601String(),
        'taskCompletionDate': taskCompletionDate,
      };

  factory TaskModel.fromEntity(TaskEntity entity) => TaskModel(
        id: entity.id,
        content: entity.content,
        description: entity.description,
        createdAt: entity.createdAt,
        taskCompletionDate: entity.taskCompletionDate,
      );
}
