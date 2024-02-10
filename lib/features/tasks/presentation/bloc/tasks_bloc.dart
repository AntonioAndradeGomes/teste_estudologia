import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/task_event.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/tasks_state.dart';

class TasksBloc extends Bloc<TaskEvent, TasksState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  TasksBloc(this.getAllTasksUseCase)
      : super(
          const LoadingTasksState(),
        ) {
    on<GetSavedTasks>(onGetSavedTasks);
    on<RemoveTask>(onRemoveTask);
    on<SaveTask>(onSaveTask);
  }

  Future<void> onGetSavedTasks(
    GetSavedTasks event,
    Emitter<TasksState> emit,
  ) async {
    final tasks = await getAllTasksUseCase.call();
    emit(
      DoneTasksState(tasks),
    );
  }

  Future<void> onRemoveTask(
    RemoveTask event,
    Emitter<TasksState> emit,
  ) async {}

  Future<void> onSaveTask(
    SaveTask event,
    Emitter<TasksState> emit,
  ) async {}
}
