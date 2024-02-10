import 'package:floor/floor.dart';
import 'package:tasks_app/features/tasks/data/models/task_model.dart';

@dao
abstract class TasksDao {
  @insert
  Future<void> insertTask(TaskModel task);

  @delete
  Future<void> deleteTask(TaskModel task);

  @Query('SELECT * FROM task')
  Future<List<TaskModel>> getAllTasks();
}
