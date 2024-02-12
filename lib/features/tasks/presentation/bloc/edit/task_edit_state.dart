import 'package:equatable/equatable.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

class TaskEditState extends Equatable {
  final TaskEntity? taskEntity;
  final String? newContent;
  final String? newDescription;
  final String? newtaskCompletionDate;

  const TaskEditState({
    this.taskEntity,
    this.newContent,
    this.newDescription,
    this.newtaskCompletionDate,
  });

  TaskEditState copyWith({
    TaskEntity? taskEntity,
    String? newContent,
    String? newDescription,
    String? newtaskCompletionDate,
  }) {
    return TaskEditState(
      taskEntity: taskEntity ?? this.taskEntity,
      newContent: newContent ?? this.newContent,
      newDescription: newDescription ?? this.newDescription,
      newtaskCompletionDate: newtaskCompletionDate,
    );
  }

  bool get isNull =>
      identical(taskEntity, newContent) &&
      identical(newDescription, newtaskCompletionDate);

  @override
  List<Object?> get props => [
        taskEntity,
        newContent,
        newDescription,
        newtaskCompletionDate,
      ];
}
