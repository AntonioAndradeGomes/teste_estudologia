import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

abstract class TasksRepository {
  Future<List<TaskEntity>> getAllTasks();
}
