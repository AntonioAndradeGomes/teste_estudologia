import 'package:tasks_app/common/usecases/usecase.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';

class ChangeStateTaskUseCase implements Usecase<void, TaskEntity> {
  final TasksRepository repository;

  ChangeStateTaskUseCase({
    required this.repository,
  });

  @override
  Future<void> call({TaskEntity? params}) {
    return repository.changeStateTask(params!);
  }
}
