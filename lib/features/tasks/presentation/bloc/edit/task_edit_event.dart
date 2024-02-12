import 'package:equatable/equatable.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

sealed class TaskEditEvent extends Equatable {
  final TaskEntity? taskEntity;
  final String? newContent;
  final String? newDescription;
  final String? newtaskCompletionDate;

  const TaskEditEvent({
    this.taskEntity,
    this.newContent,
    this.newDescription,
    this.newtaskCompletionDate,
  });

  @override
  List<Object?> get props => [
        newContent,
        newDescription,
        newtaskCompletionDate,
        taskEntity,
      ];
}

class SetInitialEvent extends TaskEditEvent {
  const SetInitialEvent(
    String? newContent,
    String? newDescription,
    String? newtaskCompletionDate,
    TaskEntity entity,
  ) : super(
          newContent: newContent,
          newDescription: newDescription,
          newtaskCompletionDate: newtaskCompletionDate,
          taskEntity: entity,
        );
}

class EditContentEvent extends TaskEditEvent {
  const EditContentEvent(String? newContent)
      : super(
          newContent: newContent,
        );
}

class EditDescriptionEvent extends TaskEditEvent {
  const EditDescriptionEvent(String? newDescription)
      : super(
          newDescription: newDescription,
        );
}

class EditTaskCompletionDateEvent extends TaskEditEvent {
  const EditTaskCompletionDateEvent(String? newtaskCompletionDate)
      : super(
          newtaskCompletionDate: newtaskCompletionDate,
        );
}

class SubmitUpdateTask extends TaskEditEvent {
  const SubmitUpdateTask();
}
