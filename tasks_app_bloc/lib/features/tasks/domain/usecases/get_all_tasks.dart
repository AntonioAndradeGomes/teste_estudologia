import 'package:tasks_app/common/usecases/usecase.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';

class GetAllTasksUseCase implements Usecase<List<TaskEntity>, void> {
  final TasksRepository repository;

  GetAllTasksUseCase({
    required this.repository,
  });

  @override
  Future<List<TaskEntity>> call({void params}) async {
    return repository.getAllTasks();
  }
}
