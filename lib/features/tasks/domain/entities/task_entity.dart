import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? content;
  final String? description;
  final String? createdAt;
  final String? taskCompletionDate;

  const TaskEntity({
    required this.id,
    required this.content,
    required this.description,
    required this.createdAt,
    required this.taskCompletionDate,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        description,
        createdAt,
        taskCompletionDate,
      ];
}
