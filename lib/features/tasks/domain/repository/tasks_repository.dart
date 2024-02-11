import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

abstract class TasksRepository {
  Future<List<TaskEntity>> getAllTasks();
  Future<int> saveTask(TaskEntity entity);
  Future<void> changeStateTask(TaskEntity entity);
  Future<void> removeTask(TaskEntity entity);
}
