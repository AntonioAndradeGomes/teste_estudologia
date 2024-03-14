import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/features/tasks/domain/usecases/edit_task.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/edit/task_edit_event.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/edit/task_edit_state.dart';

class TasksEditBloc extends Bloc<TaskEditEvent, TaskEditState> {
  final EditTaskUseCase editTaskUseCase;
  TasksEditBloc(
    this.editTaskUseCase,
  ) : super(const TaskEditState()) {
    on<SetInitialEvent>(onSetInitialEvent);
    on<EditContentEvent>(onEditContentEvent);
    on<EditDescriptionEvent>(onEditDescriptionEvent);
    on<EditTaskCompletionDateEvent>(onEditTaskCompletionDateEvent);
    on<SubmitUpdateTask>(onSubmitUpdateTask);
  }

  Future<void> onEditContentEvent(
    EditContentEvent event,
    Emitter<TaskEditState> emit,
  ) async {
    emit(
      state.copyWith(
        newContent: event.newContent,
        newtaskCompletionDate: state.newtaskCompletionDate,
      ),
    );
  }

  Future<void> onEditDescriptionEvent(
    EditDescriptionEvent event,
    Emitter<TaskEditState> emit,
  ) async {
    emit(
      state.copyWith(
        newDescription: event.newDescription,
        newtaskCompletionDate: state.newtaskCompletionDate,
      ),
    );
  }

  Future onEditTaskCompletionDateEvent(
    EditTaskCompletionDateEvent event,
    Emitter<TaskEditState> emit,
  ) async {
    emit(
      state.copyWith(
        newtaskCompletionDate: event.newtaskCompletionDate,
      ),
    );
  }

  Future<void> onSetInitialEvent(
    SetInitialEvent event,
    Emitter<TaskEditState> emit,
  ) async {
    emit(
      TaskEditState(
        taskEntity: event.taskEntity,
        newContent: event.newContent,
        newDescription: event.newDescription,
        newtaskCompletionDate: event.newtaskCompletionDate,
      ),
    );
  }

  Future<void> onSubmitUpdateTask(
    SubmitUpdateTask event,
    Emitter<TaskEditState> emit,
  ) async {
    final task = state.taskEntity!.copyWith(
      content: state.newContent,
      description: state.newDescription,
      taskCompletionDate: state.newtaskCompletionDate,
    );
    await editTaskUseCase.call(
      params: task,
    );
  }
}
