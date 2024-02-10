import 'package:equatable/equatable.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

sealed class TaskEvent extends Equatable {
  final TaskEntity? entity;

  const TaskEvent({
    this.entity,
  });

  @override
  List<Object> get props => [
        entity!,
      ];
}

class GetSavedTasks extends TaskEvent {
  const GetSavedTasks();
}

class RemoveTask extends TaskEvent {
  const RemoveTask(
    TaskEntity entity,
  ) : super(
          entity: entity,
        );
}

class SaveTask extends TaskEvent {
  const SaveTask(
    TaskEntity entity,
  ) : super(
          entity: entity,
        );
}
