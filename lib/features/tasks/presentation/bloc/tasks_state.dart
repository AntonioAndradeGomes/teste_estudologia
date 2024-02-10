import 'package:equatable/equatable.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

sealed class TasksState extends Equatable {
  final List<TaskEntity>? tasks;

  const TasksState({
    this.tasks,
  });

  @override
  List<Object> get props => tasks!;
}

class LoadingTasksState extends TasksState {
  const LoadingTasksState();
}

class DoneTasksState extends TasksState {
  const DoneTasksState(
    List<TaskEntity>? tasks,
  ) : super(
          tasks: tasks,
        );
}
