import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/domain/usecases/change_state_task.dart';
import 'package:tasks_app/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:tasks_app/features/tasks/domain/usecases/remove_task.dart';
import 'package:tasks_app/features/tasks/domain/usecases/save_task.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/list/task_event.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/list/tasks_state.dart';

class TasksBloc extends Bloc<TaskEvent, TasksState> {
  final GetAllTasksUseCase getAllTasksUseCase;
  final SaveTaskUseCase saveTaskUseCase;
  final ChangeStateTaskUseCase changeStateTaskUseCase;
  final RemoveTaskUseCase removeTaskUseCase;
  TasksBloc(
    this.getAllTasksUseCase,
    this.saveTaskUseCase,
    this.changeStateTaskUseCase,
    this.removeTaskUseCase,
  ) : super(
          const LoadingTasksState(),
        ) {
    on<GetSavedTasks>(onGetSavedTasks);
    on<RemoveTask>(onRemoveTask);
    on<SaveTask>(onSaveTask);
    on<AlterStateTask>(onAlterStateFromTask);
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
  ) async {
    await removeTaskUseCase.call(
      params: event.entity,
    );
    final tasks = await getAllTasksUseCase.call();
    emit(
      DoneTasksState(tasks),
    );
  }

  Future<void> onSaveTask(
    SaveTask event,
    Emitter<TasksState> emit,
  ) async {
    try {
      final taskId = await saveTaskUseCase.call(
        params: event.entity,
      );
      final task = event.entity!.copyWith(
        id: taskId,
      );
      final List<TaskEntity> tasks = List.from(state.tasks!);
      tasks.insert(0, task);
      emit(DoneTasksState(tasks));
      Fluttertoast.showToast(
        msg: "Tarefa adicionada com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
      );
    } catch (e, st) {
      log(
        e.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      Fluttertoast.showToast(
        msg: "Erro ao adicionar tarefa",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> onAlterStateFromTask(
    AlterStateTask event,
    Emitter<TasksState> emit,
  ) async {
    await changeStateTaskUseCase.call(
      params: event.entity,
    );
    final tasks = await getAllTasksUseCase.call();
    emit(
      DoneTasksState(tasks),
    );
  }
}
