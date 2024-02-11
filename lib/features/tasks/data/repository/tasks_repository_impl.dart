import 'package:tasks_app/common/database/app_database.dart';
import 'package:tasks_app/features/tasks/data/models/task_model.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final AppDatabase appDatabase;

  TasksRepositoryImpl({
    required this.appDatabase,
  });

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    final tasksModels = await appDatabase.taskDao.getAllTasks();
    final List<TaskEntity> tasksfinal = List.from(tasksModels);
    return tasksfinal;
  }

  @override
  Future<int> saveTask(TaskEntity entity) {
    return appDatabase.taskDao.insertTask(
      TaskModel.fromEntity(entity),
    );
  }
}
