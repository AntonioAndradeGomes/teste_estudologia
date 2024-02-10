import 'package:tasks_app/common/database/app_database.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final AppDatabase appDatabase;

  TasksRepositoryImpl({
    required this.appDatabase,
  });

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    return appDatabase.taskDao.getAllTasks();
  }
}
