import 'package:floor/floor.dart';
import 'package:tasks_app/features/tasks/data/models/task_model.dart';

@dao
abstract class TasksDao {
  @Insert(
    onConflict: OnConflictStrategy.replace,
  )
  Future<int> insertTask(TaskModel task);

  @delete
  Future<void> deleteTask(TaskModel task);

  @Query('SELECT * FROM task ORDER BY id DESC')
  Future<List<TaskModel>> getAllTasks();
}
