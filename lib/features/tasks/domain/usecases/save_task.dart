import 'package:tasks_app/common/usecases/usecase.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';

class SaveTaskUseCase implements Usecase<int, TaskEntity> {
  final TasksRepository repository;

  SaveTaskUseCase({
    required this.repository,
  });

  @override
  Future<int> call({TaskEntity? params}) {
    return repository.saveTask(params!);
  }
}
