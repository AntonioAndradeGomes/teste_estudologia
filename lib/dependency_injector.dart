import 'package:get_it/get_it.dart';
import 'package:tasks_app/common/database/app_database.dart';
import 'package:tasks_app/features/tasks/data/repository/tasks_repository_impl.dart';
import 'package:tasks_app/features/tasks/domain/repository/tasks_repository.dart';
import 'package:tasks_app/features/tasks/domain/usecases/change_state_task.dart';
import 'package:tasks_app/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:tasks_app/features/tasks/domain/usecases/remove_task.dart';
import 'package:tasks_app/features/tasks/domain/usecases/save_task.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/tasks_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  getIt.registerSingleton<AppDatabase>(database);

  getIt.registerSingleton<TasksRepository>(
    TasksRepositoryImpl(
      appDatabase: getIt(),
    ),
  );

  getIt.registerSingleton<GetAllTasksUseCase>(
    GetAllTasksUseCase(
      repository: getIt(),
    ),
  );

  getIt.registerSingleton<SaveTaskUseCase>(
    SaveTaskUseCase(
      repository: getIt(),
    ),
  );

  getIt.registerSingleton<ChangeStateTaskUseCase>(
    ChangeStateTaskUseCase(
      repository: getIt(),
    ),
  );
  //RemoveTaskUseCase

  getIt.registerSingleton<RemoveTaskUseCase>(
    RemoveTaskUseCase(
      repository: getIt(),
    ),
  );
  getIt.registerSingleton<TasksBloc>(
    TasksBloc(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
}
