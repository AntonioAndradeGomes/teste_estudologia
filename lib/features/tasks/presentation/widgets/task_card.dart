import 'package:flutter/material.dart';
import 'package:tasks_app/common/utils/extensions.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/presentation/page/edit_task_page.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity entity;
  final VoidCallback? concludOnTap;
  const TaskCard({
    super.key,
    required this.entity,
    this.concludOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTaskCompleted = entity.taskCompletionDate != null &&
        entity.taskCompletionDate!.isNotEmpty;
    return Card(
      elevation: 2,
      child: ListTile(
        dense: true,
        title: Text(
          entity.content!,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyMedium?.copyWith(
            color:
                isTaskCompleted ? Colors.white.withOpacity(0.5) : Colors.white,
            decoration: isTaskCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EditTaskPage(
                taskEntity: entity,
              ),
            ),
          );
        },
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          onPressed: concludOnTap,
          icon: Icon(
            isTaskCompleted
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
