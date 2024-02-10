import 'package:flutter/material.dart';
import 'package:tasks_app/common/utils/extensions.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity entity;
  const TaskCard({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        dense: true,
        title: Text(
          entity.content!,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {},
        contentPadding: EdgeInsets.zero,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            entity.taskCompletionDate != null
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
